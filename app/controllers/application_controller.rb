class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :is_administrator?

    # The current_user method retrieves the details of the currently logged-in user from the
    #session object. The ||= operator assigns these details to @current_user so that the
    #database is queried only once per request, even if current_user is called multiple
    #times.
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    # The logged_in? method checks if a user is logged in (set). If this method returns a
    #state of not nil, then a user is determined to be logged in.
    def logged_in?
        !current_user.nil?
    end
    # The is_administrator? method checks if the current user is an administrator based on
    #the setting of the session[:is_admin] value. If true, the user is an admin, otherwise
    #they are a standard user.
    def is_administrator?
        session[:is_admin]
    end
    # The Ruby private keyword sets all methods that follow it as private, thus preventing
    #them from being called from outside the ApplicationController object, e.g., by routes or
    #views. Thus, they can only be used internally by the application controller.
    private
    # The require_login method ensures that an action or controller is accessible only by
    #logged-in users. If not logged in as determined by the logged_in? method, this method
    #sets an error flash message and redirects the user to the login page. This method is
    #applied as a before_action in controllers where some or all of the resident methods
    #require authentication to be executed.
    def require_login
        unless logged_in?
            flash[:error] = "You are not permitted to access this resource"
            redirect_to login_path
        end

    end
end

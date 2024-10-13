class SessionsController < ApplicationController
    
    def new
    end

    def create
        user = User.find_by(email: params[:email])
        
        if user && user.authenticate(params[:password])
            if user.status == "Active"
        
                session[:user_id] = user.id
                session[:firstName] = user.firstName
                session[:is_admin] = user.is_admin
                
                if session[:is_admin]
                    redirect_to admin_path, notice: "Logged in successfully!"
                else
                    redirect_to userhome_path, notice: "Logged in successfully!"
                end
            elsif user.status == "Suspended" # based on status putput a different message to user
                flash.now[:error] = "Your account is suspended. Please contact support."
                render 'new'
            elsif user.status == "Banned"
                flash.now[:error] = "Your account is banned. Please contact support."
                render 'new'
            end
        else
            flash.now[:error] = "Invalid email or password. Please try again."
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out successfully!"
    end
end
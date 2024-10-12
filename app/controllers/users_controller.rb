class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy :update_password]
  before_action :require_login, except: [:new, :create]

  # GET /users or /users.json
  def index

    if logged_in? && is_administrator?
      @users = User.all # then retrieve all users from the database

    elsif logged_in? && !is_administrator?
      redirect_to userhome_path # redirect them to their user landing page
    else # otherwise, if no one is logged in

      flash[:error] = "You are not authorised to access this resource"
      redirect_to login_path # and then redirect to login page
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        #format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.html { redirect_to login_path, notice: "Sign up successful. Please log in." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def change_password
    @user = current_user # Get the current user for the change password form
  end

  def update_password
    respond_to do |format|
      # Ensure you are using the current user
      @user = current_user
  
      # Check if the current password is correct
      if @user.authenticate(params[:current_password]) 
        # Validate the new password and confirmation
        if params[:password].present? && params[:password] == params[:password_confirmation]
          if @user.update(password: params[:password])
            format.html { redirect_to user_url(@user), notice: "Password was successfully updated." }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :change_password, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        else
          @user.errors.add(:base, 'New passwords do not match or are blank.')
          format.html { render :change_password, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        @user.errors.add(:base, 'Current password is incorrect.')
        format.html { render :change_password, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:firstName, :lastName, :email, :password, :password_confirmation, :status, :is_admin)
    end
end

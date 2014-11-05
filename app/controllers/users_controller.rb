class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # No reason for this action
  #def index
  #  @users = User.all
  #end

  def show
  end

  def new
    @user = User.new
    @update_account = false
    render layout: "layouts/no_sidebar"
  end

  def edit
    @update_account = true
    render layout: "layouts/no_sidebar"
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        log_in @user
        params[:remember_me] == '1' ? remember(@user) : forget(@user)
        format.html do
          redirect_to root_path
          flash[:success] = 'User was successfully created.'
        end
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if not update_user_params.empty? and @user.update(update_user_params)
        format.html do
          redirect_to edit_user_path(@user)
          flash[:success] = 'User was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @user.authenticate(params[:user][:password])
      @user.destroy
      respond_to do |format|
        format.html do
          redirect_to login_path
          flash[:success] = 'User was successfully destroyed.'
        end
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html do
          redirect_to edit_user_path(@user)
          flash[:error] = 'User was not destroyed.'
        end
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_username(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
   
    # Username should not be updatable
    def update_user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def correct_user
      redirect_to root_path unless @user == current_user
    end
end

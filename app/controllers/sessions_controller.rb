class SessionsController < ApplicationController
  def create
    username, password = login_params
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      redirect_to root_path
    else
      flash.now[:login_error] = "incorrect password"
      render text: "", layout: 'layouts/application'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private
    def login_params
      params.require(:session).permit(:username, :password)
    end
end

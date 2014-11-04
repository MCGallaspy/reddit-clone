class SessionsController < ApplicationController
  def create
    user = User.find_by_username(params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_path
    else
      flash.now[:login_error] = "incorrect password"
      render text: "", layout: 'layouts/application'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end

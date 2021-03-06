class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:info] = "Welcome back #{user.name}"
      redirect_to user
    else
      flash[:danger] = 'Invalid email/password combination'
      redirect_to signin_path
    end
  end

  def destroy
    sign_out
	  redirect_to root_path
  end
end

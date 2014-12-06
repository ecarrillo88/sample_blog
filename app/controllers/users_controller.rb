class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.create(params[:user])
  	if @user.save
      flash[:success] = "Welcome to the Sample Blog!"
      render 'show'
    else
  	  render 'new'
  	end
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
    flash[:success] = "User deleted"
    redirect_to root_path
  end
end

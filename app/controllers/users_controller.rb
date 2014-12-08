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
      sign_in @user
      flash[:success] = "Welcome to the Sample Blog!"
      render 'show'
    else
  	  render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash.now[:success] = "The user has been updated!"
      render 'show'
    else
      render 'new'
    end
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
    flash[:success] = "The user has been deleted :("
    redirect_to root_path
  end
end

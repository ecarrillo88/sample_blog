require 'image_manager.rb'

class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
    @imageManager = ImageManager.new
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.create(params[:user])
  	if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample Blog!"
      redirect_to profile_path
    else
  	  render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
    @imageManager = ImageManager.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "The user has been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
    flash[:success] = "The user has been deleted :("
    redirect_to root_path
  end

  def posts_list
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  # Upload image to Cloudinary
  def upload_image
    @user = User.find(params[:id])
    if !params[:image].nil?
      imageManager = ImageManager.new
      imageManager.delete_image(@user.image_id) unless @user.image_id.nil?
      image_hash = imageManager.upload_image(params[:image])
      @user.update_attribute(:image_id, image_hash['public_id'])
      sign_in @user
      flash[:success] = "The profile image has been updated"
    else
      flash[:danger] = "Select an image before uploading"
    end
    redirect_to edit_user_path
  end
end

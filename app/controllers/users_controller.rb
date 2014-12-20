require 'image_manager.rb'

class UsersController < ApplicationController
  before_filter :find_user_filter, except: [:new, :create]
  before_filter :new_imageManager_filter, only: [:show, :edit, :upload_image]

  def find_user_filter
    @user = User.find(params[:id])
  end

  def new_imageManager_filter
    @imageManager = ImageManager.new
  end

  def show
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
  end

  def update
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "The user has been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  	@user.destroy
    flash[:success] = "The user has been deleted :("
    redirect_to root_path
  end

  def posts_list
    @posts = @user.posts
  end

  # Upload image to Cloudinary
  def upload_image
    if !params[:image].nil?
      @imageManager.delete_image(@user.image_id) unless @user.image_id.nil?
      image_hash = @imageManager.upload_image(params[:image])
      @user.update_attribute(:image_id, image_hash['public_id'])
      sign_in @user
      flash[:success] = "The profile image has been updated"
    else
      flash[:danger] = "Select an image before uploading"
    end
    redirect_to edit_user_path
  end
end

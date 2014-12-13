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
      flash.now[:success] = "The user has been updated"
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

  def posts_list
    @user = User.find(params[:id])
    @posts = @user.posts
    render 'posts_list'
  end

  # Upload image to Cloudinary
  def upload_image
    @user = User.find(params[:id])
    if !params[:image].nil?
      Cloudinary::Api.delete_resources(@user.image_id) unless @user.image_id.nil?
      image_hash = Cloudinary::Uploader.upload(params[:image])
      @user.update_attribute(:image_id, image_hash['public_id'])
      sign_in @user
      flash.now[:success] = "The profile image has been updated"
      render 'edit'
    else
      flash.now[:danger] = "Select an image before uploading"
      render 'edit'
    end
  end
end

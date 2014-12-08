class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    @comment = Comment.new
    if @post.save
      flash.now[:success] = "The post has been published!"
      render 'show'
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @comment = Comment.new
    if @post.update_attributes(params[:post])
      flash.now[:success] = "The post has been updated"
      render 'show'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:danger] = "The post has been deleted"
    redirect_to root_path
  end
end

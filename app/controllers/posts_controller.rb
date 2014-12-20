require 'post_presenter.rb'

class PostsController < ApplicationController
  before_filter :find_post_filter, only: [:show, :edit, :update, :destroy]
  before_filter :new_comment_filter, only: [:show, :create, :update]

  def find_post_filter
    @post = Post.find(params[:id])
  end

  def new_comment_filter
    @comment = Comment.new
  end

  def show
    @presenter = PostPresenter.new(view_context, @post, current_user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      @presenter = PostPresenter.new(view_context, @post, current_user)
      flash[:success] = "The post has been published!"
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @presenter = PostPresenter.new(view_context, @post, current_user)
    if @post.update_attributes(params[:post])
      flash[:success] = "The post has been updated"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:danger] = "The post has been deleted"
    redirect_to root_path
  end
end

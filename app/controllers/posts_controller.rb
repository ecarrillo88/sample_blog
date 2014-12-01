class PostsController < ApplicationController
  def show
  	@post = Post.find(params[:id])
  end

  def new
  	@post = Post.new
  end

  def create
  	@post = Post.new(params[:post])
  	if @post.save
		flash[:success] = "Post published!"
		render 'show'
	else
		flash[:error] = "Buffffffffffffff"
		render 'new'
	end
  end

  def edit
  	@post = Post.find(params[:id])
  end

  def update
  	@post = Post.find(params[:id])
  	if @post.update_attributes(params[:post])
  		flash[:success] = "Post updated"
		render 'show'
	else
		render 'edit'
	end
  end

  def destroy
  	@post = Post.find(params[:id])
  	@post.destroy
  	redirect_to root_path
  end
end

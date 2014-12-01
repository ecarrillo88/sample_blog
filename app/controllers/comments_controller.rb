class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  
  def create
    @post = Post.find(params[:id])
    @post.comments.create(user: params[:user], text: params[:text])
    redirect_to post_path(@post)
  end
end

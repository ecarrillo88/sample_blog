class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  
  def create
    @post = Post.find(params[:comment][:id])
    @comment = @post.comments.create(user: params[:comment][:user], text: params[:comment][:text])
    if @comment.save
      flash[:info] = "The comment has been published!" 
      redirect_to @post
    else
      render "posts/show"
    end
  end
end

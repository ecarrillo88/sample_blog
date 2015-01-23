class StaticPagesController < ApplicationController
  def home
    @posts = Post.all.reverse
  end

  def newPost
  end
end

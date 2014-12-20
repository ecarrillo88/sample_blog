module PostsHelper
  def last_user_name(post)
    if post.user.nil?
      return post.author
    end
    post.user.name
  end
end

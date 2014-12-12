class PostPresenter
  def initialize(view, post, current_user)
    @view = view
    @post = post
    @current_user = current_user
    @post_path = Rails.application.routes.url_helpers.post_path(@post.id)
    @edit_post_path = Rails.application.routes.url_helpers.edit_post_path(@post.id)
  end

  def is_current_user_post_owner?
    (@current_user && @post.user && @current_user.id == @post.user.id)
  end

  def display_edit_button
    @view.link_to 'Edit Post', @edit_post_path, class: "btn btn-default" if is_current_user_post_owner?
  end

  def display_delete_button
    @view.link_to 'Delete Post', "#{@post_path}/delete", class: "btn btn-default" if is_current_user_post_owner?
  end

  def no_comments_message
    "No comments :(" if @post.comments.empty?
  end
end
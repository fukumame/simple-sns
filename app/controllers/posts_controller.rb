class PostsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
  end

  def create
    post = Post.new(post_params)
    post.user = current_user
    post.save
    @posts = current_user.posts_in_feeds
  end

  def like
    @post = Post.find(params[:id])
    validate_already_liked(@post)
    favotite_post = current_user.favorite_posts.build(post: @post)
    favotite_post.save!
    render 'posts/toggle_post_like_button'
  end

  def unlike
    @post = Post.find(params[:id])
    favotite_post = current_user.favorite_posts.find_by(post: @post)
    favotite_post.destroy
    render 'posts/toggle_post_like_button'
  end

  private

  def validate_already_liked(post)
    favorite_post = current_user.favorite_posts.find_by(post_id: post.id)
    raise Exceptions::DuplicateFavoritePostError if favorite_post.present?
  end

  def post_params
    params.require(:post).permit(:content)
  end

end
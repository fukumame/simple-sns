class PostsController < ApplicationController
  before_action :retrieve_post, only: [:like, :unlike]

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
    favotite_post = current_user.favorite_posts.build(post: @post)
    favotite_post.save!
    render 'posts/toggle_post_like_button'
  end

  def unlike
    favotite_post = current_user.favorite_posts.find_by(post: @post)
    favotite_post.destroy
    render 'posts/toggle_post_like_button'
  end

  private

  def retrieve_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end

end

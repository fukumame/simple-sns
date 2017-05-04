class RepliesController < ApplicationController
  before_action :retrieve_reply, only: [:like, :unlike]

  def create
    @post = Post.find(params[:post_id])
    reply = @post.replies.build(reply_params)
    reply.user = current_user
    reply.save
  end

  def like
    favorite_reply = current_user.favorite_replies.build(reply: @reply)
    favorite_reply.save!
    render 'replies/toggle_reply_like_button'
  end

  def unlike
    favorite_reply = current_user.favorite_replies.find_by(reply: @reply)
    favorite_reply.destroy
    render 'replies/toggle_reply_like_button'
  end

  private

  def retrieve_reply
    @reply = Reply.find(params[:id])
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end

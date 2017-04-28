class RepliesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    reply = @post.replies.build(reply_params)
    reply.user = current_user
    reply.save
  end

  def like
    @reply = Reply.find(params[:id])
    validate_already_liked(@reply)
    favorite_reply = current_user.favorite_replies.build(reply: @reply)
    favorite_reply.save!
    render 'replies/toggle_reply_like_button'
  end

  def unlike
    @reply = Reply.find(params[:id])
    favorite_reply = current_user.favorite_replies.find_by(reply: @reply)
    favorite_reply.destroy
    render 'replies/toggle_reply_like_button'
  end

  private

  def validate_already_liked(reply)
    favorite_reply = current_user.favorite_replies.find_by(reply_id: reply.id)
    raise Exceptions::DuplicateFavoriteReplyError if favorite_reply.present?
  end

  def reply_params
    params.require(:reply).permit(:content)
  end
end

require 'test_helper'

class ReplyIntegrationTest < ActionDispatch::IntegrationTest

  setup do
    @main_user = create(:user_sequence)
    login_with(@main_user.email, @main_user.password)
    post posts_path, params: { post: { content: 'post content1' } }, xhr: true
    @post = User.find(@main_user.id).posts.first
  end

  test '新しいreplyの投稿とlike/unlikeの試験' do
    post post_replies_path(@post), params: { reply: { content: 'reply content1' } }, xhr: true
    assert_response :success
    result_replies = Post.find(@post.id).replies
    assert_equal 1, result_replies.size
    result_reply = result_replies.first
    assert_equal 'reply content1', result_reply.content

    #Likeの試験
    get like_reply_path(result_reply), xhr: true
    assert_response :success
    favorites = Reply.find(result_reply.id).favorites
    assert_equal 1, favorites.size
    assert_equal @main_user.id, favorites.first.user.id
    assert_equal result_reply.id, favorites.first.reply.id

    #重複してLikeを登録すると、エラーが発生すること
    assert_raises Exceptions::DuplicateFavoriteReplyError do
      get like_reply_path(result_reply), xhr: true
    end

    # replyのunlikeによって、favoritesが削除されること
    get unlike_reply_path(result_reply), xhr: true
    assert_response :success
    favorites = Reply.find(result_reply.id).favorites
    assert_equal 0, favorites.size
  end

end
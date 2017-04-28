require 'test_helper'

class PostIntegrationTest < ActionDispatch::IntegrationTest

  setup do
    @main_user = create(:user_sequence)
    login_with(@main_user.email, @main_user.password)
  end

  test '新しいPOSTの投稿とlike/unlikeの試験' do

    # 新しいPOSTの投稿
    post posts_path, params: { post: { content: 'post content1' } }, xhr: true
    assert_response :success
    result_posts = User.find(@main_user.id).posts
    assert_equal 1, result_posts.size
    result_post = result_posts[0]
    assert_equal 'post content1', result_post.content

    # Postへのlikeの実施
    get like_post_path(result_post), xhr: true
    assert_response :success
    favorites = Post.find(result_post.id).favorites
    assert_equal 1, favorites.size
    assert_equal @main_user.id, favorites[0].user.id
    assert_equal result_post.id, favorites[0].post.id

    # 重複してLikeを登録するとExceptionが発生すること
    assert_raises Exceptions::DuplicateFavoritePostError do
      get like_post_path(result_post), xhr: true
    end

    # postのunlikeによって、favoritesが削除されること
    get unlike_post_path(result_post), xhr: true
    assert_response :success
    favorites = Post.find(result_post.id).favorites
    assert_equal 0, favorites.size
  end

end
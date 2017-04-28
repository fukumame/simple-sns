require 'test_helper'

class UserTest < ActiveSupport::TestCase
  sub_test_case 'posts_in_feedsにFollowしているユーザーのpostが日付順に出されること' do
    setup do
      @main_user = create(:user)
      @target_post1 = create(:post, :with_user, created_at: '2017-01-11 10:00')
      @target_post2 = create(:post, :with_user, created_at: '2017-01-11 11:00')
      @target_post3 = create(:post, :with_user, created_at: '2017-01-11 12:00')
      @target_post4 = create(:post, user: @target_post1.user, created_at: '2017-01-11 13:00')
      @not_target_post1 = create(:post, :with_user)
      @not_target_post2 = create(:post, :with_user)
      @main_user.follows.create!(followed_user: @target_post1.user)
      @main_user.follows.create!(followed_user: @target_post2.user)
      @main_user.follows.create!(followed_user: @target_post3.user)
    end

    test 'main' do
      result_post_ids = @main_user.posts_in_feeds.collect(&:id)
      assert_equal @target_post4.id, result_post_ids[0]
      assert_equal @target_post3.id, result_post_ids[1]
      assert_equal @target_post2.id, result_post_ids[2]
      assert_equal @target_post1.id, result_post_ids[3]
    end
  end
end

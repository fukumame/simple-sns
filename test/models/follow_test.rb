require 'test_helper'

class FollowTest < ActiveSupport::TestCase

  sub_test_case 'Followeesのテスト(Followしているユーザーが正しく抽出されるか？)' do

    setup do
      @main_user = create(:user_sequence)
      @followee_user1 = create(:user_sequence)
      @followee_user2 = create(:user_sequence)
      @unfollow_user1 = create(:user_sequence)
      @main_user.follows.build(followed_user: @followee_user1)
      @main_user.follows.build(followed_user: @followee_user2)
      @main_user.save!
    end

    test 'main' do
      assert_equal 2, @main_user.followees.size
      assert_equal 3, @main_user.all_followees.size

      assert_include @main_user.all_followees.map(&:id), @followee_user1.id
      assert_include @main_user.all_followees.map(&:id), @followee_user2.id
      assert_include @main_user.all_followees.map(&:id), @main_user.id

      assert_include @main_user.followees.map(&:id), @followee_user1.id
      assert_include @main_user.followees.map(&:id), @followee_user2.id
    end
  end

  sub_test_case 'Followersのテスト(Followされているユーザーが正しく抽出されるか？)' do

    setup do
      @main_user = create(:user_sequence)
      @follower_user1 = create(:user_sequence)
      @follower_user2 = create(:user_sequence)
      @follower_user1.follows.build(followed_user: @main_user)
      @follower_user2.follows.build(followed_user: @main_user)
      @follower_user1.save!
      @follower_user2.save!
    end

    test 'main' do
      assert_include @main_user.all_followers.map(&:id), @follower_user1.id
      assert_include @main_user.all_followers.map(&:id), @follower_user2.id
      assert_include @main_user.all_followers.map(&:id), @main_user.id

      assert_include @main_user.followers.map(&:id), @follower_user1.id
      assert_include @main_user.followers.map(&:id), @follower_user2.id
    end

  end

end
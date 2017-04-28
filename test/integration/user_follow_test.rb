require 'test_helper'

class UserFollowTest < ActionDispatch::IntegrationTest

  sub_test_case ' Follow/UnFollowのテスト' do

    setup do
      @main_user = create(:user_sequence)
      @followee = create(:user_sequence)
      login_with(@main_user.email, @main_user.password)
    end

    test 'Followアクションを取ると、followerとして設定されること(逆のパターンも含む)' do
      get follow_user_path(@followee), xhr: true
      assert_response :success
      result_followee_id = User.find(@main_user.id).all_followees.map(&:id)
      assert result_followee_id.include?(@followee.id)

      get unfollow_user_path(@followee), xhr: true
      assert_response :success
      result_followee_id = User.find(@main_user.id).all_followees.map(&:id)
      assert !result_followee_id.include?(@followee.id)
    end

    test '重複してFollower登録するとExceptionが発生すること' do
      get follow_user_path(@followee), xhr: true
      assert_raises Exceptions::DuplicateFollowedUserError do
        get follow_user_path(@followee), xhr: true
      end
    end

  end

end
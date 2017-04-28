class UsersController < ApplicationController

  def index
    @users = current_user.others
  end

  # def show
  #
  # end

  def follow
    @user = User.find(params[:id])
    validate_already_followed(@user)
    follow = current_user.follows.build(followed_user: @user)
    follow.save!
    render 'users/toggle_follow_button'
  end

  def unfollow
    @user = User.find(params[:id])
    follow = current_user.follows.find_by(followed_user: @user)
    follow.destroy
    render 'users/toggle_follow_button'
  end

  private

  def validate_already_followed(user)
    followee = current_user.all_followees.find_by(id: user.id)
    raise Exceptions::DuplicateFollowedUserError if followee.present?
  end

end

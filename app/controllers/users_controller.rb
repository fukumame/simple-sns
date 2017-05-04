class UsersController < ApplicationController
  before_action :retrieve_user, only: [:follow, :unfollow]

  def index
    @users = current_user.others
  end

  def follow
    follow = current_user.follows.build(followed_user: @user)
    follow.save!
    render 'users/toggle_follow_button'
  end

  def unfollow
    follow = current_user.follows.find_by(followed_user: @user)
    follow.destroy
    render 'users/toggle_follow_button'
  end

  private

  def retrieve_user
    @user = User.find(params[:id])
  end

end

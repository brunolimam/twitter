class FollowingRelationsController < ApplicationController
  before_action :authenticate_user!

  def follow
    @followed_user = User.find(params[:user_user_name])
    @followed_user.follower_users << current_user
  end

  def unfollow
    @unfollowed_user = User.find(params[:user_user_name])
    @unfollowed_user.follower_users.delete(current_user)
  end

end

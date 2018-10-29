include ApplicationHelper
class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:follow, :unfollow]

  def mentions
    @mentions = Mention.where(user_id: current_user.id).preload(:user).preload(:tweet)
    render 'mentions/_mentions_list'
  end

  def show
    @user = User.find_by(user_name: params[:user_name]) or not_found
    @tweets = @user.tweets.order('created_at DESC').preload(:likes)
    if user_signed_in?
      @tweets = check_for_liked_tweets(@tweets)
      if current_user.blocked_users.include?(@user)
        @block_button = 'unblock'
      else
        @block_button = 'block'
      end
    end
    @follow_button = evaluate_follow
    if current_user == @user
      @tweet = Tweet.new
    end
  end

  def block
    @blocked_user = User.find(params[:user_name])
    current_user.followed_users.delete(@blocked_user)
    current_user.follower_users.delete(@blocked_user)
    current_user.blocked_users << @blocked_user
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def unblock
    @unblocked_user = User.find(params[:user_name])
    current_user.blocked_users.delete(@unblocked_user)
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  #follow an user
  def follow
    @followed_user = User.find(params[:user_name])
    @followed_user.follower_users << current_user
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def unfollow
    @unfollowed_user = User.find(params[:user_name])
    @unfollowed_user.follower_users.delete(current_user)
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  private
  def not_found
    raise ActiveRecord::RecordNotFound
  end

  def evaluate_follow
    if user_signed_in?
      if @user == current_user
        return :edit_profile
      elsif !current_user.followed_users.include?(@user)
        return :follow
      else
        return :unfollow
      end
    else
      return :sign_up
    end
  end
end

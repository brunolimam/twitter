class UsersController < ApplicationController
  def show
    @user = User.find_by(user_name: params[:user_name]) or not_found
    @tweets = @user.tweets.order('created_at DESC').preload(:likes)
    if user_signed_in?
      @tweet = Tweet.new
    end
  end


  private
  def not_found
    raise ActiveRecord::RecordNotFound
  end
end

class UsersController < ApplicationController
  def timeline
    @tweets = Tweet.all.select { |tweet| 
      current_user.followed_users.include?(tweet.user)
    }
    render "tweets/_all_user_tweets"
  end

  def show
    @user = User.find_by(user_name: params[:user_name]) or not_found
  end


  private
  def not_found
    raise ActiveRecord::RecordNotFound
  end

end

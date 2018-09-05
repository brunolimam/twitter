include ApplicationHelper
class TweetsController < ApplicationController
  helper_method :treat_tweet_content
  
  def timeline
    @followed_users_id = current_user.followed_users.pluck(:id) << current_user.id
    @tweets = Tweet.preload(:user).preload(:mentions).where(user_id: @followed_users_id).paginate(page: params[:page], :per_page => 5).order('created_at DESC')
    @tweets = check_for_liked_tweets(@tweets)
    @tweet = Tweet.new
    @follow_button = "users/edit_profile"
  end

  def create
    @tweet = Tweet.new(tweet_params)
    current_user.tweets << @tweet
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    if Like.find_by(tweet_id: params[:id], user_id: current_user.id)
      @tweet.liked = true
    else
      @tweet.liked = false
    end
    render 'tweets/_tweet', locals: {tweet: @tweet}
  end

  def like_handler
    @tweet = Tweet.find(params[:tweet_id])
    if @like = current_user.likes.find_by(tweet_id: @tweet.id)
      @like.destroy
      @tweet.liked = false
    else
      @like = Like.new(user_id: current_user.id, tweet_id: @tweet.id)
      @tweet.likes << @like
      @tweet.liked = true
    end
    @tweet.reload
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end

end

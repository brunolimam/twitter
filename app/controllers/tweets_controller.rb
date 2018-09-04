class TweetsController < ApplicationController
  def timeline
    @followed_users_id = current_user.followed_users.pluck(:id)
    @followed_users_id << current_user.id
    @tweets = Tweet.preload(:user).preload(:mentions).where(user_id: @followed_users_id).paginate(page: params[:page], :per_page => 5).order('created_at DESC')
    @likes = Like.where(user_id: current_user.id, tweet_id: @tweets.map(&:id)).pluck(:tweet_id)
    @tweet = Tweet.new
    @follow_button = "users/edit_profile"
  end

  def create
    @tweets = []
    @likes = []
    @tweet = Tweet.new(tweet_params)
    analyze_mention(@tweet)
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

  def like_handler
    @tweet = Tweet.find(params[:tweet_id])
    if @like = current_user.likes.find_by(tweet_id: @tweet.id)
      @like.destroy
    else
      @like = Like.new(user_id: current_user.id, tweet_id: @tweet.id)
      @tweet.likes << @like
    end
    @likes = Like.where(user_id: current_user.id, tweet_id: @tweet.id).map(&:tweet_id)
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

  def analyze_tweet_content(tweet)
    mention = tweet[/[@][a-zA-Z1-9]*/]
    if mention
      return mention[1,mention.length]
    else
      return nil
    end
  end

  def analyze_mention(tweet)
    @mention = analyze_tweet_content(tweet.content)
    if @mention != nil
      @user = User.find_by(user_name: @mention)
      if @user != nil
        @created_mention = Mention.create(tweet_id: @tweet.id, user_id: @user.id)
        @tweet.mentions << @created_mention
      end
    end
  end

  def treat_tweet_content(tweet)
    new_content = tweet.content
    mention = analyze_tweet_content(tweet.content)
    new_content.sub! "@#{mention}", ""
  end

  helper_method :treat_tweet_content
end

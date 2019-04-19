class TweetsController < ApplicationController
  def index
    if params[:search].present?
      tweet_text = params[:tweet_text]
      like_num = params[:like_num].to_i
      @tweets = Tweet.search(current_user.id, tweet_text,like_num)
    elsif params[:sort]
      @tweets = current_user.tweets.order("favorite_count DESC")
    else
      @tweets = current_user.tweets
    end
  end

  def update
    Tweet.find_by(id: params[:id]).cliped!
    redirect_to(tweets_path)
  end
end

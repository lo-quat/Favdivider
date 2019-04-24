class TweetsController < ApplicationController
  def index
    if params[:sort]
      @tweets = current_user.tweets.order("favorite_count DESC")
    elsif
      @tweets = current_user.tweets
    end
  end

  def update
    Tweet.find_by(id: params[:id]).cliped!
    redirect_to(tweets_path)
  end

  def edit
    @tweet = Tweet.find_by(id: params[:id])
  end
end

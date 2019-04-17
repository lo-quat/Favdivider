class TweetsController < ApplicationController
  def index
    search = params[:search]
    number = params[:number].to_i
    if search || number
      @tweets = Tweet.search(current_user.id, search,number)
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

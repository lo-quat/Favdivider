class TweetsController < ApplicationController
  def index
    if params[:sort]
      @tweets = current_user.tweets.order("favorite_count DESC")
    elsif
      @tweets = current_user.tweets
    end
  end
end

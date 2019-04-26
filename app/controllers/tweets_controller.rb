class TweetsController < ApplicationController
  def index
    if params[:search].present?
      @tweets = Tweet.search(current_user.id, {tweet_text: params[:tweet_text],like_num: params[:like_num]})
    elsif params[:sort]
      @tweets = current_user.tweets.order("favorite_count DESC")
    else
      @tweets = current_user.tweets
    end
  end

  def update
    relationship = Relationship.new(category_id: params[:relationship][:category],
                                    tweet_id: params[:relationship][:tweet_id])
    relationship.save
    redirect_to edit_tweet_url(params[:relationship][:tweet_id])
  end

  def edit
    @tweet = current_user.tweets.find(params[:id])
  end

  def clip
    Tweet.find_by(id: params[:id]).cliped!
    redirect_to(tweets_path)
  end
end

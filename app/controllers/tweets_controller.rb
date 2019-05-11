class TweetsController < ApplicationController
  def index
    if user_signed_in?
      if params[:search].present?
        @tweets = Tweet.search(current_user.id, {tweet_text: params[:tweet_text],
                                                 like_num: params[:like_num],
                                                 category_id: params[:category_id]})
      elsif params[:sort]
        @tweets = current_user.tweets.reorder(favorite_count: "DESC")
      else
        @tweets = current_user.tweets
      end
    end
  end

  def edit
    @tweet = current_user.tweets.find(params[:id])
    @relationship = @tweet.relationships.new
  end

  def update
    relationship = Relationship.new(tweet_params)

    if relationship.save
      redirect_to edit_tweet_url(params[:relationship][:tweet_id])
    end
  end

  def clip
    Tweet.find_by(id: params[:id]).cliped!
    redirect_to(tweets_path)
  end

  def post_users
    @post_users = Tweet.post_users(current_user)
  end

  def post_user_tweets
    @tweets = Tweet.where(user_id: current_user, postuser_id: params[:postuser_id])
  end

  private

  def tweet_params
    params.require(:relationship).permit(:category_id, :tweet_id)
  end
end

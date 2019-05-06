class TweetsController < ApplicationController
  def index
    if params[:search].present?
      @tweets = Tweet.search(current_user.id, {tweet_text: params[:tweet_text], like_num: params[:like_num]})
    elsif params[:sort]
      @tweets = current_user.tweets.reorder(favorite_count: "DESC")
    else
      @tweets = current_user.tweets
    end

    @postuser_name_all = Tweet.postuser_name_all(current_user)
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

  private

  def tweet_params
    params.require(:relationship).permit(:category_id,:tweet_id)
  end
end

class TweetsController < ApplicationController

  def index
    if user_signed_in?
      if params[:search].present?
        @tweets = Tweet.search(current_user.id, {tweet_text: params[:tweet_text],
                                                 like_num: params[:like_num],
                                                 clip: params[:clip],
                                                 category_id: params[:category_id][0]})
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

  def toggle_status
    tweet = Tweet.find_by(id: params[:id])
    tweet.toggle_clip!
    respond_to do |format|
      format.json{render json: {status: tweet.status}}
    end
  end

  def post_user_tweets
    @tweets = current_user.post_users.find(params[:post_user_id]).tweets
    render action: :index
  end

  private

  def tweet_params
    params.require(:relationship).permit(:category_id, :tweet_id)
  end
end

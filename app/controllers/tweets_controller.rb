class TweetsController < ApplicationController

  def index
    if user_signed_in?
      if params[:search].present?
        @tweets = Tweet.search(current_user.id, {tweet_text: params[:tweet_text],
                                                 like_num: params[:like_num],
                                                 clip: params[:clip],
                                                 category_id: params[:category_id][0],
                                                 post_user_id: params[:post_user_id]})
      elsif params[:sort]
        @tweets = current_user.tweets.reorder(favorite_count: "DESC")
      elsif params[:quote]
        @tweets = current_user.tweets.where(is_quote_status: true)
      elsif params[:image]
        @tweets = current_user.tweets.joins(:tweet_images,:tweet_video).where()
      else
        @tweets = current_user.tweets
      end
    end
  end

  def edit
    @tweet = current_user.tweets.find(params[:id])
    @categories = current_user.categories
  end

  def update
    relationship = Relationship.new(tweet_id: params[:tweet_id],category_id: params[:category_id])

    if relationship.save
      flash.now[:notice] = "Add Category"
      render body: nil
    end
  end

  def toggle_status
    tweet = Tweet.find_by(id: params[:id])
    tweet.toggle_clip!
    respond_to do |format|
      format.json {render json: {status: tweet.status}}
    end
  end

end

class TweetsController < ApplicationController
  before_action :login_required

  def index
    if params[:search].present?
      @tweets = Tweet.search(current_user.id, tweet_text: params[:tweet_text],
                                              like_num: params[:like_num],
                                              clip: params[:clip],
                                              category_id: params[:category_id][0],
                                              post_user_id: params[:post_user_id])
    elsif params[:sort]
      @tweets = current_user.tweets.reorder(favorite_count: 'DESC')
    elsif params[:quote]
      @tweets = current_user.tweets.where(is_quote_status: true)
    else
      @tweets = current_user.tweets
    end
  end

  def edit
    @tweet = current_user.tweets.find(params[:id])
    @categories = current_user.categories
  end

  def update
    @relationship = Relationship.new(tweet_id: params[:tweet_id], category_id: params[:category_id])
    @category = Category.find(params[:category_id]).name
    respond_to do |format|
      if @relationship.save
        format.js {@status = 'success'}
      else
        format.js {@status = 'fail'}
      end
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

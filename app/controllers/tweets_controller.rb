class TweetsController < ApplicationController
  before_action :login_required
  before_action :set_tweet, only: [:edit, :toggle_status]

  def index
    parameters = Parameter.new(params).define_params
    @tweets = Tweet.search(current_user.id, parameters).page(params[:page]).per(30)
  end

  def edit
    @categories = current_user.categories
    @category = Category.new
  end

  def update
    @relationship = Relationship.new(tweet_id: params[:id], category_id: params[:category_id])
    @category = Category.find(params[:category_id])
    respond_to do |format|
      if @relationship.save
        format.js {@status = 'success'}
      else
        format.js {@status = 'fail'}
      end
    end
  end

  def toggle_status
    @tweet.toggle_clip!
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end
end

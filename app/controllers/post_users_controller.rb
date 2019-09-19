class PostUsersController < ApplicationController
  before_action :set_post_user, only: [:show, :edit, :update, :destroy]
  before_action :login_required

  # GET /post_users
  # GET /post_users.json
  def index
    @post_users = current_user.post_users.select('post_users.*', 'count(tweets.post_user_id) AS tweets')
                      .left_joins(:tweets)
                      .group('tweets.post_user_id')
                      .order('tweets desc')
  end

  def show
    @tweets = current_user.post_users.find(params[:id]).tweets
  end

  # PATCH/PUT /post_users/1
  # PATCH/PUT /post_users/1.json
  def update
    respond_to do |format|
      if @post_user.update(post_user_params)
        format.html {redirect_to @post_user, notice: 'Post user was successfully updated.'}
        format.json {render :show, status: :ok, location: @post_user}
      else
        format.html {render :edit}
        format.json {render json: @post_user.errors, status: :unprocessable_entity}
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post_user
    @post_user = PostUser.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_user_params
    params.fetch(:post_user, {})
  end
end

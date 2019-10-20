class PostUsersController < ApplicationController
  before_action :set_post_user, only: [:show, :update]
  before_action :login_required

  # GET /post_users
  # GET /post_users.json
  def index
    words = params[:q].delete(:search_words_cont) if params[:q].present?
    if words.present?
      params[:q][:groupings] = []
      words.split(/[ 　]/).each_with_index do |word, i| #全角空白と半角空白で切って、単語ごとに処理
        params[:q][:groupings][i] = { search_words_cont: word }
      end
    end
    @q = current_user.post_users.ransack(params[:q])
    @post_users = @q.result.sort_by{ |q| -q.tweets.size }# デフォルトでツイートの多い順に表示
  end

  def show
    @tweets = current_user.post_users.find(params[:id]).tweets.page(params[:page]).per(30)
    render template: 'tweets/index'
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

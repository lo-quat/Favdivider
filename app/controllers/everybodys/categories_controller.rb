class Everybodys::CategoriesController < Everybodys::Base
  before_action :set_category, only: [:show]

  def index
    @categories = Category.where(status: :publish).group(:name).having('count(*) >= 1')
  end

  def show
    # 任意のカテゴリーに紐づけられたツイート一覧を表示する
    # 別のユーザが同じ名前のカテゴリー名を作成している場合、同じ名前でツイートをまとめる
    if params[:user].present?
      tweets = User.find(params[:user]).categories.find(params[:id]).tweets
    else
      tweets = Category.merge_same_category_tweet(@category.name)
    end

    @tweets = tweets.page(params[:page]).per(30)
    render template: 'everybodys/tweets/index'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end

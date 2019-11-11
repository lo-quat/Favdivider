class Everybodys::CategoriesController < Everybodys::Base
  before_action :set_category, only: [:show]

  def index
    @categories = Category.where(status: :publish)
  end

  def show
    # 任意のカテゴリーに紐づけられたツイート一覧を表示する
    @tweets = @category.tweets.page(params[:page]).per(30)
    render template: 'tweets/index'
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end

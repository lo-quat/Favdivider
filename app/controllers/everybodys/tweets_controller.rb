class Everybodys::TweetsController < Everybodys::Base
  def index
    # カテゴリー付きで公開ツイートのみを抽出
    # 公開/非公開設定はカテゴリーごとに設定してある
    @tweets = Tweet.joins(:categories).where(categories: { status: :publish }).distinct
  end
end

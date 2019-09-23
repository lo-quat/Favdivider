class Everybodys::TweetsController < Everybodys::Base
  def index
    # カテゴリー付ツイートのみを取り出す
    @tweets = Tweet.joins(:relationships).where('relationships.tweet_id is not null')
  end
end

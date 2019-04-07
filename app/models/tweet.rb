class Tweet < ApplicationRecord
  require 'twitter'
  has_many :tweet_images ,dependent: :destroy
  belongs_to :user

  def self.fetch(user)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['APP_ID']
      config.consumer_secret = ENV['APP_SECRET']
      config.access_token = user.access_token
      config.access_token_secret = user.access_token_secret
    end

    #一旦全削除
    user.tweets.destroy_all


    def collect_with_max_id(collection=[], max_id=nil, &block)
      response = yield(max_id)
      collection += response
      response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
    end

    # いいね全件取得
    def client.get_all_favorites(user)
      collect_with_max_id do |max_id|
        options = {count: 200,tweet_mode:"extended"}
        options[:max_id] = max_id unless max_id.nil?
        favorites(user, options)
      end
    end


    favorites = client.get_all_favorites(user.twitter_id)

    favorites.each do |favorite|
      user.tweets.create(
                             post_id: favorite.id,
                             post_created_at: favorite.created_at,
                             text: favorite.attrs[:full_text],
                             favorite_count: favorite.favorite_count,
                             retweet_count: favorite.retweet_count,
                             postuser_id: favorite.user.id,
                             postuser_name: favorite.user.name,
                             postuser_screen_name: favorite.user.screen_name,
                             profile_description: favorite.user.description
      )
      #ツイートに画像があれば保存
      if favorite.media?
        favorite.media.each do |media|
          user.tweets.last.tweet_images.create(
                                           tweetimage_url: media.media_url_https
          )
        end
      end
    end
  end
end

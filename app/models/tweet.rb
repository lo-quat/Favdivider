class Tweet < ApplicationRecord
  enum status: { default: 0, cliped: 1 }
  has_many :tweet_images, dependent: :destroy
  belongs_to :user

  def self.fetch(user)

    Tweet.transaction do
      client = Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['APP_ID']
        config.consumer_secret = ENV['APP_SECRET']
        config.access_token = user.access_token
        config.access_token_secret = user.access_token_secret
      end

      #一旦全削除
      user.tweets.each do |tweet|
        tweet.destroy!
      end

      tweets = client.favorites(count: 200, tweet_mode: "extended")

      tweets.each do |tweet|
        _tweet = user.tweets.new(
            post_id: tweet.id,
            post_created_at: tweet.created_at,
            text: tweet.attrs[:full_text],
            favorite_count: tweet.favorite_count,
            retweet_count: tweet.retweet_count,
            postuser_id: tweet.user.id,
            postuser_name: tweet.user.name,
            postuser_screen_name: tweet.user.screen_name,
            profile_description: tweet.user.description
        )
        #ツイートに画像があれば保存
        if tweet.media?
          tweet.media.each do |media|
            _tweet.tweet_images.new(tweetimage_url: media.media_url_https)
          end
        end
        _tweet.save!
      end
    end
    rescue
    render :action => 'users/edit'
  end
end

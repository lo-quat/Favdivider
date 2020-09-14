# frozen_string_literal: true

class Tweet < ApplicationRecord
  enum status: { default: 0, cliped: 1 }
  has_many :tweet_images, dependent: :destroy
  has_many :tweet_videos, dependent: :destroy
  has_many :relationships, dependent: :destroy
  accepts_nested_attributes_for :relationships, allow_destroy: true
  has_many :categories, through: :relationships, dependent: :destroy
  belongs_to :user
  belongs_to :post_user
  validates :user_id, :post_user_id, :status, presence: true
  validates :relationships, length: { maximum: 3 }

  default_scope -> { order(post_created_at: :DESC) }

  def self.fetch(user)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['APP_ID']
      config.consumer_secret = ENV['APP_SECRET']
      config.access_token = user.access_token
      config.access_token_secret = user.access_token_secret
    end

    # def collect_with_max_id(collection = [], max_id = nil, &block)
    #   response = yield(max_id)
    #   collection += response
    #   response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
    # end
    #
    # # いいね全件取得
    # def client.get_all_favorites(user)
    #   collect_with_max_id do |max_id|
    #     options = {count: 200, tweet_mode: "extended"}
    #     options[:max_id] = max_id unless max_id.nil?
    #     favorites(user, options)
    #   end
    # end

    tweets = client.favorites(user.uid.to_i, count: 200, tweet_mode: 'extended')
    Tweet.transaction do
      tweets.each do |tweet|
        next unless Tweet.new_tweet?(user.id, tweet.id)

        post_user = user.post_users.find_by(uid: tweet.user.id).presence
        if post_user # 投稿ユーザーがDBにすでにある場合
          _tweet = post_user.tweets.new(
            user_id: user.id,
            post_id: tweet.id,
            post_created_at: tweet.created_at,
            text: tweet.attrs[:full_text],
            favorite_count: tweet.favorite_count,
            is_quote_status: tweet.quoted_status?
          ).tap(&:save) # 一度セーブしてidを付与しバリデーションを通るようにする
        elsif post_user.nil? # 新規の投稿ユーザーの場合
          _tweet = user.post_users.new(
            uid: tweet.user.id,
            name: tweet.user.name,
            screen_name: tweet.user.screen_name,
            profile_description: tweet.user.description,
            profile_image: tweet.user.profile_image_url_https
          ).tap(&:save).tweets.new(
            user_id: user.id,
            post_id: tweet.id,
            post_created_at: tweet.created_at,
            text: tweet.attrs[:full_text],
            favorite_count: tweet.favorite_count,
            is_quote_status: tweet.quoted_status?
          ).tap(&:save)
        end
        if tweet.media?
          tweet.media.each do |media|
            if media.type == 'video'
              media.video_info.variants.each do |variant|
                if variant.content_type == 'video/mp4'
                  isBreak = true
                  _tweet.tweet_videos.new(tweet_video_url: variant.url,
                                          thumbnail: media.media_url_https)
                end
                break if isBreak
              end
            else
              _tweet.tweet_images.new(tweet_image_url: media.media_url_https)
            end
          end
        end
        _tweet.save!
      end
    end
  rescue StandardError
  end

  def self.search(user_id, queries = {})
    tweets = Tweet.where(user_id: user_id)
    return tweets if tweets.blank?

    if queries[:tweet_text].present?
      tweets = tweets.where('text LIKE ?', "%#{queries[:tweet_text]}%")
    end

    if queries[:like_num].present?
      tweets = tweets.where(favorite_count: queries[:like_num]..Float::INFINITY)
    end

    tweets = tweets.where(status: 1) if queries[:clip].present?

    if queries[:category_id].present?
      tweets = tweets.joins(:relationships).where(relationships: { category_id: queries[:category_id] })
    end

    tweets = tweets.reorder(favorite_count: 'DESC') if queries[:sort].present?

    tweets = tweets.where(is_quote_status: true) if queries[:quote].present?

    tweets = tweets.joins(:tweet_videos) if queries[:video].present?

    tweets = tweets.joins(:tweet_images).distinct if queries[:image].present?

    if queries[:reply].present?
      tweets = tweets.where('text LIKE ?', "@#{User.find(user_id).screen_name}%")
    end

    if queries[:hash_tag].present?
      tweets = tweets.where('text LIKE ?', "%#{queries[:hash_tag]}%")
    end

    tweets
  end

  def self.new_tweet?(user_id, tweet_id)
    Tweet.find_by(user_id: user_id, post_id: tweet_id).nil?
  end

  def toggle_clip!
    if default?
      cliped!
    else
      default!
    end
  end

  def self.hashtag_index(user)
    hashtags = user.tweets.where('text LIKE ?', '%#%').map do |tweet|
      tweet.text.scan(/#(\w+|(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+)/)
    end
    hashtags.flatten.group_by(&:downcase).map { |key, value| [key, value.count] }.to_h.sort_by { |_key, value| -value }.to_h
  end
end

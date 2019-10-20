class TweetVideo < ApplicationRecord
  belongs_to :tweet
  validates :tweet_id, presence: true
end

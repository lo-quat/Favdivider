class Relationship < ApplicationRecord
  belongs_to :tweet
  belongs_to :category
  validates :tweet_id, uniqueness: { scope: :category_id }
end

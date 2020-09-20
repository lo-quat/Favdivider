class Category < ApplicationRecord
  has_many :relationships, dependent: :destroy
  has_many :tweets, through: :relationships, dependent: :destroy
  belongs_to :user
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :status, :user_id, presence: true
  enum status: { unpublish: 0, publish: 1 }

  def toggle_status!
    unpublish? ? publish! : unpublish!
  end

  def self.merge_same_category_tweet(category_name)
    same_category = Category.where(name: category_name, status: :publish)
    if same_category.count > 1
      tweets = same_category.inject do |category, n|
        category.tweets.or(n.tweets)
      end
    elsif
      tweets = same_category.first.tweets
    end
    tweets
  end
end

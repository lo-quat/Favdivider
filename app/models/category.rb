class Category < ApplicationRecord
  has_many :relationships, dependent: :destroy
  has_many :tweets, through: :relationships, dependent: :destroy
  belongs_to :user
  validates :name, presence: true, uniqueness: true
  enum status: { unpublish: 0, publish: 1 }
end

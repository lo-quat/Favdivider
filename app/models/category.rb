class Category < ApplicationRecord
  has_many :relationships, dependent: :destroy
  has_many :tweets, through: :relationships,dependent: :destroy
  belongs_to :user
  validates :name, presence: true,uniqueness: true
end

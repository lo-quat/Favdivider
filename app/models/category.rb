class Category < ApplicationRecord
  has_many :relationships
  has_many :tweets, through: :relationships
  validates :name, presence: true
end

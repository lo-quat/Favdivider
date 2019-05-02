class Category < ApplicationRecord
  has_many :relationships
  has_many :tweets, through: :relationships
  belongs_to :user
  validates :name, presence: true,uniqueness: true
end

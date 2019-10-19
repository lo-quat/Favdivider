class Category < ApplicationRecord
  has_many :relationships, dependent: :destroy
  has_many :tweets, through: :relationships, dependent: :destroy
  belongs_to :user
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :status, :user_id, presence: true
  enum status: { unpublish: 0, publish: 1 }

  def toggle_status!
    if unpublish?
      publish!
    else
      unpublish!
    end
  end
end

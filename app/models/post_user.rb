class PostUser < ApplicationRecord
  belongs_to :user
  has_many :tweets
  validates :user_id, presence: true

  def self.exist_post_user?(uid)
    PostUser.find_by(uid: uid)
  end
end

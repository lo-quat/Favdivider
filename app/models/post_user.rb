class PostUser < ApplicationRecord
  belongs_to :user
  has_many :tweets
  validates :user_id, presence: true
  ransack_alias :search_words, :name_or_screen_name_or_profile_description

  def self.exist_post_user?(uid)
    PostUser.find_by(uid: uid)
  end
end

# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :post_users, dependent: :destroy
  has_many :categories, dependent: :destroy
  validates :email, :encrypted_password, :uid, :access_token, :access_token_secret, presence: true
  validates :name, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :trackable

  def self.find_for_oauth(auth)
    User.find_or_create_by(uid: auth.uid, provider: auth.provider) do |user|
      user.uid = auth.uid
      user.provider = auth.provider
      user.access_token = auth[:credentials][:token]
      user.access_token_secret = auth[:credentials][:secret]
      user.email = User.dummy_email(auth)
      user.password = Devise.friendly_token[0, 20]
      user.name = auth[:info][:name]
      user.screen_name = auth[:info][:nickname]
      user.description = auth[:info][:description]
      user.profile_image = auth[:info][:image]
    end
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  def authenticated?
    access_token_secret.present?
  end
end

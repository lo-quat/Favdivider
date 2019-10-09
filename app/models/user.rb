class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :post_users, dependent: :destroy
  has_many :categories, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
          uid:      auth.uid,
          provider: auth.provider,
          access_token: auth[:credentials][:token],
          access_token_secret: auth[:credentials][:secret],
          email:    User.dummy_email(auth),
          password: Devise.friendly_token[0, 20]
      )
    end

    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  def authenticated?
    access_token_secret.present?
  end
end

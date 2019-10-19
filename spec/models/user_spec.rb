require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with uid, access_token, access_token_secret, email, and password" do
    user = User.new(uid: Faker::Number.unique.number(digits: 16),
                    access_token: Faker::Lorem.characters(),
                    access_token_secret: Faker::Lorem.characters(),
                    email: Faker::Internet.email,
                    password: Faker::Internet.password)
    user.valid?
    expect(user).to be_valid
  end
  it "is invalid without uid" do
    user = User.new(uid: nil)
    user.valid?
    expect(user.errors[:uid]).to include("can't be blank")
  end
  it "is invalid without access_token" do
    user = User.new(access_token: nil)
    user.valid?
    expect(user.errors[:access_token]).to include("can't be blank")
  end
  it "is invalid without access_token_secret" do
    user = User.new(access_token_secret: nil)
    user.valid?
    expect(user.errors[:access_token_secret]).to include("can't be blank")
  end
  it "is invalid without email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  it "is invalid without password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
end
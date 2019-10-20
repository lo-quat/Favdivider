require 'rails_helper'

RSpec.describe PostUser, type: :model do
  it "is valid with user_id" do
    user = create(:user)
    post_user = PostUser.new(user_id: user.id)
    post_user.valid?
    expect(user).to be_valid
  end
  it "is invalid without user_id" do
    post_user = PostUser.new(user_id: nil)
    post_user.valid?
    expect(post_user.errors[:user_id]).to include("can't be blank")
  end
end

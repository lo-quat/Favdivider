require 'rails_helper'

RSpec.describe TweetImage, type: :model do
  it "is valid with tweet_id" do
    tweet = create(:tweet1, :skip_validate)
    tweet_image = TweetImage.new(tweet_id: tweet.id)
    tweet_image.valid?
    expect(tweet_image).to be_valid
  end
  it "is invalid without tweet_id" do
    tweet_image = TweetImage.new(tweet_id: nil)
    tweet_image.valid?
    expect(tweet_image.errors[:tweet_id]).to include("can't be blank")
  end
end

require 'rails_helper'

RSpec.describe TweetVideo, type: :model do
  it "is valid with tweet_id" do
    tweet = create(:tweet1, :skip_validate)
    tweet_video = TweetVideo.new(tweet_id: tweet.id)
    tweet_video.valid?
    expect(tweet_video).to be_valid
  end
  it "is invalid without tweet_id" do
    tweet_video = TweetVideo.new(tweet_id: nil)
    tweet_video.valid?
    expect(tweet_video.errors[:tweet_id]).to include("can't be blank")
  end
end

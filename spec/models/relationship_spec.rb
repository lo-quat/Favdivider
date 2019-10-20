require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @tweet = create(:tweet1, :skip_validate)
    @category = create(:category, :skip_validate)
  end
  it "is valid with tweet_id and category_id" do
    relationship = Relationship.new(tweet_id: @tweet.id,
                                    category_id: @category.id)
    relationship.valid?
    expect(relationship).to be_valid
  end
  it "is invalid without tweet_id" do
    relationship = Relationship.new(tweet_id: nil)
    relationship.valid?
    expect(relationship.errors[:tweet_id]).to include("can't be blank")
  end
  it "is invalid without category_id" do
    relationship = Relationship.new(category_id: nil)
    relationship.valid?
    expect(relationship.errors[:category_id]).to include("can't be blank")
  end
  # 一つのツイートに同じカテゴリーを与えることはできない
  it "does not allow a single tweet to have categories which has the same name" do
    Relationship.create(tweet_id: @tweet.id, category_id: @category.id)
    relationship = Relationship.new(tweet_id: @tweet.id, category_id: @category.id)
    relationship.valid?
    expect(relationship.errors[:tweet_id]).to include("has already been taken")
  end
end
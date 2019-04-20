require 'rails_helper'

RSpec.describe Tweet, type: :model do

  before do
    @user = create(:user)
    create(:tweet1)
    create(:tweet2)
    create(:tweet3)
  end

  it 'ツイートテキストといいね数両方の指定で検索結果の件数,内容が正しいか' do
    results = Tweet.search(@user.id, {tweet_text: 'abc', like_num: 10})
    expect(results.count).to eq (1)
    results.each do |result|
      expect(result.text.start_with?('abc') && result.favorite_count >= 10).to eq true
    end
  end

  it 'ツイートテキストのみの指定で検索結果の件数,内容が正しいか' do
    results = Tweet.search(@user.id, {tweet_text: 'abc'})
    expect(results.count).to eq (2)
    results.each do |result|
      expect(result.text.start_with?('abc')).to eq true
    end
  end

  it 'いいね数のみの指定で検索結果の件数,内容が正しいか' do
    results = Tweet.search(@user.id, {like_num: 10})
    expect(results.count).to eq (1)
  end

  it '検索指定条件なし' do
    results = Tweet.search(@user.id)
    expect(results.count).to eq (3)
  end
end

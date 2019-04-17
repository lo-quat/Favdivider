require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it '検索結果の件数,内容が正しいか' do
    user = create(:user)
    create(:tweet1)
    create(:tweet2)
    create(:tweet3)
    results = Tweet.search(user.id,'abc',10)
    expect(results.count).to eq (1)
    results.each do |result|
      expect(result.text.start_with?('abc')&&result.favorite_count >= 10).to eq true
    end
  end
end

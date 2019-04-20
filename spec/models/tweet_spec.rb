require 'rails_helper'

RSpec.describe Tweet, type: :model do

  before do
    @user = create(:user)
  end

  describe "#search" do

    context "テキスト検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) {create(:tweet1)}
        let!(:tweet2) {create(:tweet2)}
        it "件数、内容が正しいか" do
          results = Tweet.search(@user.id, {tweet_text: 'abc'})
          expect(results.count).to eq (1)
          expect(results.first.text.start_with?('abc')).to eq(true)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1) {create(:tweet1)}
        let!(:tweet2) {create(:tweet2)}
        it "該当ツイートが存在しないか" do
          results = Tweet.search(@user.id, {tweet_text: 'rfb'})
          expect(results.count).to eq(0)
        end
      end
    end

    context "ライク検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) {create(:tweet1)}
        let!(:tweet3) {create(:tweet3)}
        it '件数、内容が正しいか' do
          results = Tweet.search(@user.id, {like_num: 10})
          expect(results.count).to eq (1)
          expect(results.first.favorite_count >= 10).to eq(true)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1) {create(:tweet1)}
        let!(:tweet3) {create(:tweet3)}
        it '該当ツイートが存在しないか' do
          results = Tweet.search(@user.id, {like_num: 20})
          expect(results.count).to eq (0)
        end
      end
    end

    context "複合検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) {create(:tweet1)}
        let!(:tweet3) {create(:tweet3)}
        it '件数、内容が正しいか' do
          results = Tweet.search(@user.id, {tweet_text: 'abc',like_num: 10})
          expect(results.count).to eq (1)
          expect(results.first.text.start_with?('abc') && results.first.favorite_count >= 10).to eq(true)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1) {create(:tweet1)}
        let!(:tweet3) {create(:tweet3)}
        it '該当ツイートが存在しないか' do
          results = Tweet.search(@user.id,{tweet_text: 'abc',like_num: 100})
          expect(results.count).to eq (0)
        end
      end
    end

    context "検索条件の指定がない場合" do
      let!(:tweet1) {create(:tweet1)}
      let!(:tweet2) {create(:tweet2)}
      let!(:tweet3) {create(:tweet3)}
      it '全件のツイートが表示されるか' do
        results = Tweet.search(@user.id)
        expect(results.count).to eq(3)
      end
    end
  end
end

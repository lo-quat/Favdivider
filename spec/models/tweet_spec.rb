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
        let!(:results){Tweet.search(@user.id, {tweet_text: 'abc'})}
        it "件数が正しいこと、内容が正しいこと" do
          expect(results.count).to eq (1)
          expect(results.first.text.start_with?('abc')).to eq(true)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1) {create(:tweet1)}
        let!(:tweet2) {create(:tweet2)}
        let!(:results){Tweet.search(@user.id, {tweet_text: 'rfb'})}
        it "該当ツイートが存在しないこと" do
          expect(results.count).to eq(0)
        end
      end
    end

    context "ライク検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) {create(:tweet1)}
        let!(:tweet3) {create(:tweet3)}
        let!(:results){Tweet.search(@user.id, {like_num: 10})}
        it "件数が正しいこと、内容が正しいこと" do
          expect(results.count).to eq (1)
          expect(results.first.favorite_count >= 10).to eq(true)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1) {create(:tweet1)}
        let!(:tweet3) {create(:tweet3)}
        let!(:results){Tweet.search(@user.id, {like_num: 20})}
        it "該当ツイートが存在しないこと" do
          expect(results.count).to eq (0)
        end
      end
    end

    context "複合検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) {create(:tweet1)}
        let!(:tweet3) {create(:tweet3)}
        let!(:results){Tweet.search(@user.id, {tweet_text: 'abc',like_num: 10})}
        it "件数が正しいこと、内容が正しいこと" do
          expect(results.count).to eq (1)
          expect(results.first.text.start_with?('abc') && results.first.favorite_count >= 10).to eq(true)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1) {create(:tweet1)}
        let!(:tweet3) {create(:tweet3)}
        let!(:results){Tweet.search(@user.id,{tweet_text: 'abc',like_num: 100})}
        it "該当ツイートが存在しないこと" do
          expect(results.count).to eq (0)
        end
      end
    end

    context "検索条件の指定がない場合" do
      let!(:tweet1) {create(:tweet1)}
      let!(:tweet2) {create(:tweet2)}
      let!(:tweet3) {create(:tweet3)}
      let!(:results){Tweet.search(@user.id)}
      it "全件のツイートが取得されること" do
        expect(results.count).to eq(3)
      end
    end
  end
end

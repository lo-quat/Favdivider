require 'rails_helper'

RSpec.describe Tweet, type: :model do

  before do
    @user = create(:user)
    @post_user = create(:post_user)
  end

  describe "validation" do
    it "is valid with user_id, post_user_id and status" do
      tweet = Tweet.new(
          user_id: 1,
          post_user_id: 1,
          status: 0
      )
      expect(tweet).to be_valid
    end

    it "is invalid without user_id" do
      tweet = Tweet.new(
          user_id: nil,
          post_user_id: 1,
          status: 0
      )
      tweet.valid?
      expect(tweet.errors[:user_id]).to include("can't be blank")
    end

    it "is invalid without post_user_id" do
      tweet = Tweet.new(
          user_id: 1,
          post_user_id: nil,
          status: 0
      )
      tweet.valid?
      expect(tweet.errors[:post_user_id]).to include("can't be blank")
    end

    it "is invalid without status" do
      tweet = Tweet.new(
          user_id: 1,
          post_user_id: 1,
          status: nil
      )
      tweet.valid?
      expect(tweet.errors[:status]).to include("can't be blank")
    end
  end

  describe "#search" do

    context "テキスト検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) { create(:tweet1) }
        let!(:tweet2) { create(:tweet2) }
        let!(:results) { Tweet.search(@user.id, {tweet_text: 'abc'}) }
        it "件数が正しいこと" do
          expect(results.count).to eq(1)
        end

        it "内容が正しいこと" do
          expect(results.first.id).to eq(tweet1.id)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1) { create(:tweet1) }
        let!(:tweet2) { create(:tweet2) }
        let!(:results) { Tweet.search(@user.id, {tweet_text: 'rfb'}) }
        it "該当ツイートが存在しないこと" do
          expect(results.count).to eq(0)
        end
      end
    end

    context "ライク検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) { create(:tweet1) }
        let!(:tweet3) { create(:tweet3) }
        let!(:results) { Tweet.search(@user.id, {like_num: 10}) }
        it "件数が正しいこと" do
          expect(results.count).to eq(1)
        end
        it "内容が正しいこと" do
          expect(results.first.id).to eq(tweet1.id)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1) { create(:tweet1) }
        let!(:tweet3) { create(:tweet3) }
        let!(:results) { Tweet.search(@user.id, {like_num: 20}) }
        it "該当ツイートが存在しないこと" do
          expect(results.count).to eq(0)
        end
      end
    end

    context "カテゴリー検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) { create(:tweet1) }
        let!(:category) { create(:category) }
        let!(:relationship) { create(:relationship) }
        let!(:results) { Tweet.search(@user.id, {category_id: 1}) }
        it "件数が正しいこと" do
          expect(results.count).to eq(1)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1) { create(:tweet1) }
        let!(:results) { Tweet.search(@user.id, {category_id: 1}) }
        it "該当チートが存在しないこと" do
          expect(results.count).to eq(0)
        end
      end
    end

    context "クリップ検索" do
      context "検索結果が存在する場合" do
        let!(:tweet3) { create(:tweet3) }
        let!(:results) { Tweet.search(@user.id, {clip: 1}) }
        it "件数が正しいこと" do
          expect(results.count).to eq(1)
        end
        it "内容が正しいこと" do
          expect(results.first.status).to eq("cliped")
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1){ create(:tweet1) }
        let!(:results){ Tweet.search(@user.id,{clip:1})}
        it "該当ツイートが存在しないこと" do
          expect(results.count).to eq(0)
        end
      end
    end

    context "動画検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) { create(:tweet1) }
        let!(:tweet_video) { create(:tweet_video) }
        let!(:results) { Tweet.search(@user.id, {video: 1}) }
        it "件数が正しいこと" do
          expect(results.count).to eq(1)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1){ create(:tweet1) }
        let!(:results){ Tweet.search(@user.id,{video:1})}
        it "該当ツイートが存在しないこと" do
          expect(results.count).to eq(0)
        end
      end
    end

    context "引用検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) { create(:tweet1) }
        let!(:results) { Tweet.search(@user.id, {quote: 1}) }
        it "件数が正しいこと" do
          expect(results.count).to eq(1)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet2){ create(:tweet2) }
        let!(:results){ Tweet.search(@user.id,{quote:1})}
        it "該当ツイートが存在しないこと" do
          expect(results.count).to eq(0)
        end
      end
    end

    context "画像検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) { create(:tweet1) }
        let!(:tweet_image) { create(:tweet_image) }
        let!(:results) { Tweet.search(@user.id, {image: 1}) }
        it "件数が正しいこと" do
          expect(results.count).to eq(1)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1){ create(:tweet1) }
        let!(:results){ Tweet.search(@user.id,{image:1})}
        it "該当ツイートが存在しないこと" do
          expect(results.count).to eq(0)
        end
      end
    end

    context "複合検索" do
      context "検索結果が存在する場合" do
        let!(:tweet1) { create(:tweet1) }
        let!(:tweet3) { create(:tweet3) }
        let!(:results) { Tweet.search(@user.id, {tweet_text: 'abc', like_num: 10}) }
        it "件数が正しいこと" do
          expect(results.count).to eq(1)
        end
        it "内容が正しいこと" do
          expect(results.first.id).to eq(tweet1.id)
        end
      end

      context "検索結果が存在しない場合" do
        let!(:tweet1) { create(:tweet1) }
        let!(:tweet3) { create(:tweet3) }
        let!(:results) { Tweet.search(@user.id, {tweet_text: 'abc', like_num: 100}) }
        it "該当ツイートが存在しないこと" do
          expect(results.count).to eq(0)
        end
      end
    end

    context "検索条件の指定がない場合" do
      let!(:tweet1) { create(:tweet1) }
      let!(:tweet2) { create(:tweet2) }
      let!(:tweet3) { create(:tweet3) }
      let!(:results) { Tweet.search(@user.id) }
      it "全件のツイートが取得されること" do
        expect(results.count).to eq(3)
      end
    end
  end
end

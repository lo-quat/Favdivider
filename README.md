# Favdivider
Twitterのいいね を管理するサービス

[ここ](https://favdivider.herokuapp.com)に公開しています

Heroku無料枠のためいいねツイート件数を200件(1回の問い合わせで取得できる最大件数)に制限しています。

いいね全件取得は下記コードのコメントアウトでできます。 (app/models/tweet.rb#L24)

```
    # def collect_with_max_id(collection = [], max_id = nil, &block)
    #   response = yield(max_id)
    #   collection += response
    #   response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
    # end
    #
    # # いいね全件取得
    # def client.get_all_favorites(user)
    #   collect_with_max_id do |max_id|
    #     options = {count: 200, tweet_mode: "extended"}
    #     options[:max_id] = max_id unless max_id.nil?
    #     favorites(user, options)
    #   end
    # end

```

## 開発環境

ruby 2.5.3
Rails 5.2.3

## 機能

Twitterのいいね を管理します。

* ユーザー別、動画、画像、引用、それぞれの一覧
![index](https://user-images.githubusercontent.com/39546415/69833450-5550fa80-1277-11ea-9985-58be37ef1974.gif)
* クリップ機能
![clip](https://user-images.githubusercontent.com/39546415/69833466-63068000-1277-11ea-849b-90b60da9cc51.gif)
* カテゴライズ
![categorize](https://user-images.githubusercontent.com/39546415/69833461-5eda6280-1277-11ea-8e5d-6600cfbbb18e.gif)
* このサービス内での他ユーザとの共有
* カテゴリー単位で共有設定切り替え
  *カテゴリー一覧ではFavdividerユーザーが同名カテゴリーを作成、公開設定している場合、同名カテゴリーツイートをまとめて表示する
  *ユーザー一覧ではそれぞれのカテゴライズされたツイートを表示する
![toggle_publish](https://user-images.githubusercontent.com/39546415/69833468-64d04380-1277-11ea-9389-8175b05eb3ac.gif)

## なぜ作ったか

私は、Twitterで様々なジャンルの情報を追っていてあとで目を通そうと思ったものはお気に入りしておくという習慣があります。
特に、サッカーに関するものが多く、各チームの情報を分けて保存しておきたいのです。
しかし、いざ読み返そうとした時にお気に入りの数が多すぎて探すのに苦労することがよくあったので
すぐに見つけられるような機能が欲しいと思い作りました。(まだまだ未完成)
また、私と同じような人にも利用してもらってカテゴライズされた「良い情報」が集まればいいなと思います。

## 追加したい機能

* スレッド付ツイートの一覧表示
* 外部リンクを含むツイートの一覧表示
* カテゴリの推測(投稿主が加えられているリスト一覧を取ってきて tf-idfで重要単語をカテゴリーにする、みたいなことがしたい)

## 現時点での課題
1. スレッド有無が取得できるAPIが用意されていないのでどうするか
2. 初回ログイン時にお気に入り一覧を取得しているが、API制限により15000件までしか取得できない。15000件以上のアカウントだとエラー
3. 現在の仕様では毎回、お気に入り全件を問い合わせている。２回目以降ログイン時には差分だけAPI問合せできるようにしたい。
4. 3.を実装しようとすると以下問題点が考えられる
APIの仕様が　"いいね” をした順番ではなく　”いいね” をしたツイートが投稿された日付順　で取得されるので、取得漏れが発生する可能性がある
Favdividerに記録されている最新のツイートよりも古いツイートを「いいね」に追加した場合に取得漏れが発生する

class CreateTweetImages < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_images do |t|
      t.string :tweetimage_url
      t.references :tweet, foreign_key: true

      t.timestamps
    end
  end
end

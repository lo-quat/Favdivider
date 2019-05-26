class CreateTweetVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_videos do |t|
      t.string :tweet_video_url
      t.references :tweet, foreign_key: true
      t.timestamps
    end
  end
end

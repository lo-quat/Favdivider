class AddThumbnailToTweetVideo < ActiveRecord::Migration[5.2]
  def change
    add_column :tweet_videos, :thumbnail, :string
  end
end

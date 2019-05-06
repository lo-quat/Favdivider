class AddImageToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets,:postuser_profile_image,:string
  end
end

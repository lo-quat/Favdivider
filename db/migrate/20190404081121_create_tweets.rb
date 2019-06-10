class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :post_id
      t.datetime :post_created_at
      t.string :text
      t.integer :favorite_count
      t.integer :retweet_count
      t.references :user, foreign_key: true
      t.references :post_user, foreign_key: true
      t.timestamps
    end
  end
end
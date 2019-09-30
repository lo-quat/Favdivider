class AddStatusToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :status, :integer, null: false, default: 0
  end
end

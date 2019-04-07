class AddTwitterIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :twitter_id, :integer
  end
end

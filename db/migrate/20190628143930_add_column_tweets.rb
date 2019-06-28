class AddColumnTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets,:is_quote_status,:boolean
  end
end

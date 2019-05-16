class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :uid
      t.string :provider
      t.string :access_token
      t.string :access_token_secret

      t.timestamps
    end
  end
end
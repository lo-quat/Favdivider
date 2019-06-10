class CreatePostUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :post_users do |t|
      t.string :uid
      t.string :name
      t.string :screen_name
      t.string :profile_description
      t.string :profile_image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
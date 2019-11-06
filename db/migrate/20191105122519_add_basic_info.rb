class AddBasicInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :screen_name, :string
    add_column :users, :description, :string
  end
end

class AddStatusToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :status, :integer, null: false, default: 0
  end
end

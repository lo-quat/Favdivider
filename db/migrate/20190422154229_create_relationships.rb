class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :tweet, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end

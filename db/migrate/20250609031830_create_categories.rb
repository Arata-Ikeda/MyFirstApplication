class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :desplay_order

      t.timestamps
    end
  end
end

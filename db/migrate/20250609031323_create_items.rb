class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :memo
      t.string :image_path
      t.integer :category_id
      t.integer :brand_id
      t.integer :season_id
      t.integer :user_id

      t.timestamps
    end
  end
end

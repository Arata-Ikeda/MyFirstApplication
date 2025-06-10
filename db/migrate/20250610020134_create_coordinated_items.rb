class CreateCoordinatedItems < ActiveRecord::Migration[8.0]
  def change
    create_table :coordinated_items do |t|
      t.references :coordinate, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end

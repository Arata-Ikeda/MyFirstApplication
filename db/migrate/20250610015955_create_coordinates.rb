class CreateCoordinates < ActiveRecord::Migration[8.0]
  def change
    create_table :coordinates do |t|
      t.date :worn_on
      t.text :memo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

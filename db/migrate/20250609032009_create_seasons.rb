class CreateSeasons < ActiveRecord::Migration[8.0]
  def change
    create_table :seasons do |t|
      t.string :name
      t.integer :display_order

      t.timestamps
    end
  end
end

class AddPriceToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :price, :integer
  end
end

class AddDisplayOrderToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :display_order, :integer
  end
end

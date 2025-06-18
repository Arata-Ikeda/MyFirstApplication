class AddUserToBrands < ActiveRecord::Migration[8.0]
  def change
    add_reference :brands, :user, null: true, foreign_key: true
    add_index :brands, [:user_id, :name], unique: true
  end
end
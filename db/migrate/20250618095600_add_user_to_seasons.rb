class AddUserToSeasons < ActiveRecord::Migration[8.0]
  def change
    add_reference :seasons, :user, null: true, foreign_key: true
    add_index :seasons, [:user_id, :name], unique: true
  end
end
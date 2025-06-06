class AddGoogleFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :google_id, :string
    add_column :users, :icon_url, :string
  end
end

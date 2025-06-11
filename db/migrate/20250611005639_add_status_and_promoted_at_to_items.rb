class AddStatusAndPromotedAtToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :status, :integer
    add_column :items, :promoted_to_owned_at, :datetime
  end
end

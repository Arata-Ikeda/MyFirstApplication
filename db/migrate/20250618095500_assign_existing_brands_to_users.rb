class AssignExistingBrandsToUsers < ActiveRecord::Migration[8.0]
  def up
    # 各ユーザーに対して、そのユーザーのアイテムで使用されているブランドを割り当てる
    User.find_each do |user|
      # そのユーザーのアイテムで使用されている全てのブランドID（重複を除く）
      brand_ids = user.items.pluck(:brand_id).compact.uniq
      
      # 各ブランドに対して処理
      brand_ids.each do |brand_id|
        brand = Brand.find_by(id: brand_id)
        next unless brand
        
        # ユーザーIDがnilのブランドの場合、そのブランドを更新
        if brand.user_id.nil?
          brand.update(user_id: user.id)
        else
          # 既に他のユーザーに紐付いている場合は、新しくブランドを作成
          new_brand = user.brands.find_or_create_by(name: brand.name)
          # このブランドを使用している、現在のユーザーのアイテムを更新
          user.items.where(brand_id: brand_id).update_all(brand_id: new_brand.id)
        end
      end
    end
    
    # user_idがnilのブランドで、アイテムに紐付いていないものは削除
    Brand.where(user_id: nil).left_joins(:items).where(items: { id: nil }).destroy_all
  end
  
  def down
    # ロールバック時は、全てのブランドのuser_idをnilに戻す
    Brand.update_all(user_id: nil)
  end
end
class AssignExistingSeasonsToUsers < ActiveRecord::Migration[8.0]
  def up
    # 各ユーザーに対して、そのユーザーのアイテムで使用されているシーズンを割り当てる
    User.find_each do |user|
      # そのユーザーのアイテムで使用されている全てのシーズンID（重複を除く）
      season_ids = user.items.pluck(:season_id).compact.uniq
      
      # 各シーズンに対して処理
      season_ids.each do |season_id|
        season = Season.find_by(id: season_id)
        next unless season
        
        # ユーザーIDがnilのシーズンの場合、そのシーズンを更新
        if season.user_id.nil?
          season.update(user_id: user.id)
        else
          # 既に他のユーザーに紐付いている場合は、新しくシーズンを作成
          new_season = user.seasons.find_or_create_by(name: season.name)
          # このシーズンを使用している、現在のユーザーのアイテムを更新
          user.items.where(season_id: season_id).update_all(season_id: new_season.id)
        end
      end
    end
    
    # user_idがnilのシーズンで、アイテムに紐付いていないものは削除
    Season.where(user_id: nil).left_joins(:items).where(items: { id: nil }).destroy_all
  end
  
  def down
    # ロールバック時は、全てのシーズンのuser_idをnilに戻す
    Season.update_all(user_id: nil)
  end
end
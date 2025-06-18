namespace :db do
  desc "Reset all data except categories"
  task reset_except_categories: :environment do
    puts "Resetting all data except categories..."
    
    # ActiveStorageの添付ファイルを削除
    ActiveStorage::Attachment.destroy_all
    ActiveStorage::Blob.destroy_all
    
    # 各モデルのデータを削除（カテゴリー以外）
    CoordinatedItem.destroy_all
    Coordinate.destroy_all
    Item.destroy_all
    Brand.destroy_all
    Season.destroy_all
    User.destroy_all
    
    puts "Data reset complete. Categories remain intact."
    puts "Remaining categories: #{Category.count}"
  end
end
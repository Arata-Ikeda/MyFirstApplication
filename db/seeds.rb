# db/seeds.rb

# カテゴリーの初期データ
# レコードが存在しない場合のみ作成する
unless Category.exists?
  Category.create!([
    { name: 'トップス', display_order: 10 },
    { name: 'ジャケット', display_order: 20 },
    { name: 'アウター', display_order: 30 },
    { name: 'ボトムス', display_order: 40 },
    { name: 'ヘッドウェア', display_order: 50 },
    { name: 'アイウェア', display_order: 60 },
    { name: 'アクセサリー', display_order: 70 },
    { name: 'シューズ', display_order: 80 },
    { name: 'その他服飾雑貨', display_order: 90 }
  ])
  puts 'Categories seeded!'
else
  puts 'Categories already exist, skipping seed.'
end

# ブランドの初期データ（任意）
unless Brand.exists?
  Brand.create!([
    { name: 'Comme des Garcons home plus' },
    { name: 'Comme des Garcons shirt' },
    { name: 'Nike' },
    { name: 'Adidas' },
    { name: 'Levi\'s' }
  ])
  puts 'Brands seeded!'
else
  puts 'Brands already exist, skipping seed.'
end

# シーズンの初期データ（任意）
unless Season.exists?
  Season.create!([
    { name: '古着', display_order: 200 },
    { name: '70s', display_order: 210 },
    { name: '80s', display_order: 220 },
    { name: '90s', display_order: 230 },
    { name: '00s', display_order: 240 },
    { name: '23SS', display_order: 50 },
    { name: '23AW', display_order: 40 },
    { name: '24SS', display_order: 30 },
    { name: '24AW', display_order: 20 },
    { name: '25SS', display_order: 10 }
  ])
  puts 'Seasons seeded!'
else
  puts 'Seasons already exist, skipping seed.'
end
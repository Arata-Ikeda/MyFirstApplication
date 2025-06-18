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

# ブランドの初期データは各ユーザーごとに作成されるため、
# グローバルなブランドは作成しない
puts 'Brands are now user-specific. Skipping global brand seed.'

# シーズンの初期データは各ユーザーごとに作成されるため、
# グローバルなシーズンは作成しない
puts 'Seasons are now user-specific. Skipping global season seed.'
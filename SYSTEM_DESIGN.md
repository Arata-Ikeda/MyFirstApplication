# システム設計書

## アーキテクチャ設計
MVC（Model-View-Controller）

## コンテナ図
- クライアント：Webブラウザ
- Webアプリケーション：Ruby on Rails
- データベース：PostgreSQL
- デプロイ環境：Render

## コンポーネント図作成
- View（記録一覧、入力フォームなど）
- Controller（記録の追加、編集、削除）
- Model（User、Meal、Food など）
- Database（PostgreSQL）　※6/6までしか使えないらしい

各コンポーネントはMVC構造に従い、以下のように分担：
- View：画面表示とフォーム
- Controller：ルーティングと処理制御
- Model：データ管理と関連づけ

## データモデル設計

### エンティティ一覧

| エンティティ名   | 説明                                      |
|------------------|-------------------------------------------|
| **User** | アプリの利用者情報                        |
| **Item** | ユーザーが所有する洋服・服飾品の情報      |
| **Coordinate** | コーディネート投稿の記録                  |
| **CoordinateItem** | コーディネートと所持品の紐付け（中間テーブル） |
| **WishlistItem** | 欲しいものリストのアイテム情報            |

### 関係性（リレーション）

- User 1 : N Item (一人のユーザーが複数のアイテムを持つ)
- User 1 : N Coordinate (一人のユーザーが複数のコーディネートを投稿する)
- User 1 : N WishlistItem (一人のユーザーが複数の欲しいものリストアイテムを持つ)
- Coordinate N : M Item (一つのコーディネートに複数のアイテムが使用され、一つのアイテムが複数のコーディネートで使用される。`CoordinateItem` 中間テーブルを介する)

### Userテーブルの属性

| カラム名   | 型      | 制約           | 備考                                      |
|------------|---------|----------------|-------------------------------------------|
| id         | integer | 主キー         | 自動採番                                  |
| email      | string  | NOT NULL, UNIQUE | ログインに使うメールアドレス (Google認証の識別子) |
| name       | string  |              | ユーザー名 (Google認証から取得、任意)   |
| uid        | string  | NOT NULL, UNIQUE | Google認証のユーザーID                    |
| provider   | string  | NOT NULL       | 認証プロバイダー (`google_oauth2` など)   |
| created_at | datetime| NOT NULL       | レコード作成日時                          |
| updated_at | datetime| NOT NULL       | レコード更新日時                          |
| (その他)   |         |                | Deviseによって自動生成されるカラム (例: `encrypted_password` などは、Google認証のみの場合は使われないが、Deviseが生成するため記載) |
| (画像)     |         |                | プロフィール画像 (Active Storageで別途管理) |

### Itemテーブルの属性

| カラム名        | 型      | 制約     | 備考                                          |
|-----------------|---------|----------|-----------------------------------------------|
| id              | integer | 主キー   | 自動採番                                      |
| user_id         | integer | NOT NULL | 外部キー（Userテーブルのid）                  |
| category        | integer | NOT NULL | カテゴリー（Enum: headwear, tops, etc.）        |
| brand_name      | string  |          | ブランド名（任意）                            |
| season          | string  |          | シーズン（例: 25SS, 25AW、任意）                |
| purchase_year   | integer |          | 購入年（任意）                                |
| purchase_month  | integer |          | 購入月（任意）                                |
| price           | decimal |          | 価格（任意）                                  |
| shop_name       | string  |          | 購入店（任意）                                |
| memo            | text    |          | メモ（任意）                                  |
| purchase_date   | date    |          | 購入日（任意、購入済み移行機能で入力）        |
| created_at      | datetime| NOT NULL | レコード作成日時                              |
| updated_at      | datetime| NOT NULL | レコード更新日時                              |
| (画像)          |         |          | 画像 (Active Storageで別途管理)               |

### Coordinateテーブルの属性

| カラム名      | 型      | 制約     | 備考                                      |
|---------------|---------|----------|-------------------------------------------|
| id            | integer | 主キー   | 自動採番                                  |
| user_id       | integer | NOT NULL | 外部キー（Userテーブルのid）              |
| title         | string  |          | コーディネートのタイトル（任意）          |
| description   | text    |          | コーディネートの説明やメモ（任意）        |
| status        | integer | NOT NULL | 公開設定（Enum: private, public）         |
| created_at    | datetime| NOT NULL | レコード作成日時                          |
| updated_at    | datetime| NOT NULL | レコード更新日時                          |
| (画像)        |         |          | メイン画像 (Active Storageで別途管理)     |

### CoordinateItemテーブルの属性

| カラム名      | 型      | 制約     | 備考                                      |
|---------------|---------|----------|-------------------------------------------|
| id            | integer | 主キー   | 自動採番                                  |
| coordinate_id | integer | NOT NULL | 外部キー（Coordinateテーブルのid）        |
| item_id       | integer | NOT NULL | 外部キー（Itemテーブルのid）              |
| created_at    | datetime| NOT NULL | レコード作成日時                          |
| updated_at    | datetime| NOT NULL | レコード更新日時                          |

### WishlistItemテーブルの属性

| カラム名      | 型      | 制約     | 備考                                      |
|---------------|---------|----------|-------------------------------------------|
| id            | integer | 主キー   | 自動採番                                  |
| user_id       | integer | NOT NULL | 外部キー（Userテーブルのid）              |
| brand_name    | string  |          | ブランド名（任意）                        |
| price         | decimal |          | 想定価格（任意）                          |
| release_date  | date    |          | 発売日（任意）                            |
| memo          | text    |          | メモ（任意）                              |
| season        | integer |          | シーズン（Enum: 25SS, 25AW、任意）        |
| priority      | integer |          | 欲しい時期/優先度（Enum: now, someday、任意） |
| created_at    | datetime| NOT NULL | レコード作成日時                          |
| updated_at    | datetime| NOT NULL | レコード更新日時                          |
| (画像)        |         |          | 画像 (Active Storageで別途管理)           |

### ER図 (Mermaid記法)

```mermaid
erDiagram
    User ||--o{ Item : has
    User ||--o{ Coordinate : posts
    User ||--o{ WishlistItem : desires

    Coordinate ||--o{ CoordinateItem : contains
    Item ||--o{ CoordinateItem : used_in

    Item {
        INTEGER id PK
        INTEGER user_id FK "Foreign key to User"
        INTEGER category "Enum: headwear, tops, etc. NOT NULL"
        VARCHAR brand_name
        VARCHAR season
        INTEGER purchase_year
        INTEGER purchase_month
        DECIMAL price
        VARCHAR shop_name
        TEXT memo
        DATE purchase_date
        DATETIME created_at NOT NULL
        DATETIME updated_at NOT NULL
        %% image (Active Storageで別途管理)
    }

    User {
        INTEGER id PK
        VARCHAR email "Unique, NOT NULL"
        VARCHAR name
        VARCHAR uid "Unique, NOT NULL, for Google Auth"
        VARCHAR provider "NOT NULL, for Google Auth"
        DATETIME created_at NOT NULL
        DATETIME updated_at NOT NULL
        %% プロフィール画像 (Active Storageで別途管理)
        %% Deviseによって自動生成される他のカラムも考慮
    }

    Coordinate {
        INTEGER id PK
        INTEGER user_id FK "Foreign key to User"
        VARCHAR title
        TEXT description
        INTEGER status "Enum: private, public. NOT NULL"
        DATETIME created_at NOT NULL
        DATETIME updated_at NOT NULL
        %% image (Active Storageで別途管理)
    }

    CoordinateItem {
        INTEGER id PK
        INTEGER coordinate_id FK "Foreign key to Coordinate"
        INTEGER item_id FK "Foreign key to Item"
        DATETIME created_at NOT NULL
        DATETIME updated_at NOT NULL
    }

    WishlistItem {
        INTEGER id PK
        INTEGER user_id FK "Foreign key to User"
        VARCHAR brand_name
        DECIMAL price "Assumed price"
        DATE release_date
        TEXT memo
        INTEGER season "Enum: 25SS, 25AW"
        INTEGER priority "Enum: now, someday"
        DATETIME created_at NOT NULL
        DATETIME updated_at NOT NULL
        %% image (Active Storageで別途管理)
    }
class User < ApplicationRecord
  has_one_attached :icon
  has_many :coordinates
  has_many :items
  has_many :brands, dependent: :destroy
  has_many :seasons, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }
  validates :icon, presence: true

  # OmniAuthからの情報を使ってユーザーを検索または作成するクラスメソッド
  def self.from_omniauth(auth)
    where(google_id: auth.uid).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.google_id = auth.uid
      user.icon_url = auth.info.image
      user.save!
    end
  end
end
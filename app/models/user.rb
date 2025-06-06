class User < ApplicationRecord
  # Deviseの機能を使うために必要なモジュールをインクルード
  include Devise::Models # ★この行が、class User の直下にあることを確認！

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  # OmniAuthからの情報を使ってユーザーを検索または作成するクラスメソッド
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end
end
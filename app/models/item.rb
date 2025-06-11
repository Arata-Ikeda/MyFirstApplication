class Item < ApplicationRecord
    belongs_to :user
    belongs_to :category
    belongs_to :brand
    belongs_to :season

    has_many :coordinated_items, dependent: :destroy
    has_many :coordinates, through: :coordinated_items    

    has_one_attached :item_image

    enum :status, { wish: 0, owned: 1 }, prefix: true

    accepts_nested_attributes_for :brand
    accepts_nested_attributes_for :season

    validates :name, presence: true, length: { maximum: 20 }
    validates :memo, length: { maximum: 100 }
    validates :category_id, presence: true
    validates :item_image, presence: true
    validates :brand, presence: true
end

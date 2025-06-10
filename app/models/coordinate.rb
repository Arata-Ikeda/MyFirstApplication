class Coordinate < ApplicationRecord
  belongs_to :user
  has_one_attached :coordinate_image
  has_many :coordinated_items, dependent: :destroy
  has_many :items, through: :coordinated_items

  validates :worn_on, presence: true
  validates :memo, length: { maximum: 100 }
  validates :coordinate_image, presence: true
end

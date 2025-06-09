class Brand < ApplicationRecord
    has_many :items, dependent: :destroy

    validates :name, presence: true, length: { maximum: 40 }
end

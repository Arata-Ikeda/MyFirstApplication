class Season < ApplicationRecord
    has_many :items, dependent: :destroy

    validates :name, presence: true, length: { maximum: 20 }
end

class Brand < ApplicationRecord
    belongs_to :user, optional: true
    has_many :items, dependent: :destroy

    validates :name, presence: true, length: { maximum: 40 }
    validates :name, uniqueness: { scope: :user_id }
end

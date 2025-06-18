class Season < ApplicationRecord
    belongs_to :user, optional: true
    has_many :items, dependent: :destroy

    validates :name, presence: true, length: { maximum: 20 }
    validates :name, uniqueness: { scope: :user_id }
end

class Product < ApplicationRecord
    belongs_to :store
    has_many :purchases, dependent: :destroy
    has_one_attached :image
   validates :title, presence: true
   validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
   validates :item_count, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
end

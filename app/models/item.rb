class Item < ApplicationRecord
    has_one_attached :image
    belongs_to :genre
    has_many :cart_items, dependent: :destroy
    has_many :order_items, dependent: :destroy
    
    def with_cost
        (price*1.1).floor
    end    
end

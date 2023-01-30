class CartItem < ApplicationRecord
    belongs_to :customer
    belongs_to :item
    
    def subtotal
        item.with_cost * amount
    end    
end

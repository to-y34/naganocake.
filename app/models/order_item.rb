class OrderItem < ApplicationRecord
    belongs_to :item
    belongs_to :order
    
    def in_cost
    ( cost * 1.1 ).floor
    end
  
  def sub_total
    in_cost * amount
  end  
end

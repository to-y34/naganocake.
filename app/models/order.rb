class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_items, dependent: :destroy
    
    enum payment: { credit_card: 0, transfer: 1 }
    
    def all_sub_total
    total = 0
    order_items.each do |order_item|
    total += order_item.in_cost * order_item.amount
    end
    total
    end
 
  def billing_amount
    all_sub_total + delivery_charge
  end
end

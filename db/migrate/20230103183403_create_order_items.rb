class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :item_id
      t.integer :oders_id
      t.integer :amount
      t.integer :cost
      t.integer :status
      t.timestamps
    end
  end
end

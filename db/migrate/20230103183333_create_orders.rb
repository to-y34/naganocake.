class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :address
      t.string :postal_code
      t.string :name
      t.integer :payment
      t.integer :status
      t.integer :delivery_charge
      t.integer :billing_amount
      t.timestamps
    end
  end
end

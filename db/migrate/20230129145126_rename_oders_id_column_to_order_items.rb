class RenameOdersIdColumnToOrderItems < ActiveRecord::Migration[6.1]
  def change
    rename_column :order_items, :oders_id, :order_id
  end
end

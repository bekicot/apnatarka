class AddColumnInOrderItems < ActiveRecord::Migration[5.1]
  def change
  	add_column :order_items, :item_status, :integer, default: 0
  end
end

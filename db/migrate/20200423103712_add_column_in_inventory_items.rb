class AddColumnInInventoryItems < ActiveRecord::Migration[5.1]
  def change
  	add_column :inventory_items, :stock_quantity, :float
  	add_column :inventory_items, :discount, :float
  	add_column :inventory_items, :total_expense, :float
  end
end

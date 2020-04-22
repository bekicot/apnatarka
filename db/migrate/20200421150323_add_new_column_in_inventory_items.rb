class AddNewColumnInInventoryItems < ActiveRecord::Migration[5.1]
  def change
  	add_column :inventory_items, :total_price, :float
  end
end

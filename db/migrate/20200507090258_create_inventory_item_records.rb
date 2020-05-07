class CreateInventoryItemRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :inventory_item_records do |t|
    	t.references :item
    	t.float :total_quantity
    	t.float :used_quantity
      t.timestamps
    end
  end
end

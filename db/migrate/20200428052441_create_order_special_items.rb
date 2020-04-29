class CreateOrderSpecialItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_special_items do |t|
    	t.references :order
    	t.references :special_item
    	t.float :quantity
    	t.float :price
      t.timestamps
    end
  end
end

class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :order
      t.references :menu_item
      t.integer :quantity
      t.float :total

      t.timestamps
    end
  end
end

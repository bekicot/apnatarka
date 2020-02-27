class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :order
      t.references :chef_category_item
      t.integer :quantity
      t.float :total
      t.string :special_request

      t.timestamps
    end
  end
end

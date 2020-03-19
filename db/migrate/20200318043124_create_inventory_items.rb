class CreateInventoryItems < ActiveRecord::Migration[5.1]
  def change
    create_table :inventory_items do |t|
      t.references :item
      t.float :price
      t.float :quantity
      t.integer :measure, default: 0
      t.float :used
      t.datetime :indate
      t.string :slug
      t.timestamps
    end
  end
end

class ChnageColumnOfInventoryItem < ActiveRecord::Migration[5.1]
  def change
  	change_column :inventory_items, :measure, :string
  end
end

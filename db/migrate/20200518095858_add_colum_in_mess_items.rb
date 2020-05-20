class AddColumInMessItems < ActiveRecord::Migration[5.1]
  def change
  	add_column :mess_items, :price, :float
  end
end

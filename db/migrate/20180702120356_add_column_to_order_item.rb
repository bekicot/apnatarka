class AddColumnToOrderItem < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :special_request, :string
  end
end

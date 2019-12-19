class AddFieldsToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :ordered_as, :integer
    add_column :orders, :vat, :float
    add_column :orders, :long, :float
    add_column :orders, :lat, :float
    add_column :orders, :is_location_check, :boolean
  end
end

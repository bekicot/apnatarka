class AddPicktimeToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :delivery_time, :datetime
  end
end

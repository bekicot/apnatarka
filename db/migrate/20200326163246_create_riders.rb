class CreateRiders < ActiveRecord::Migration[5.1]
  def change
    create_table :riders do |t|
    	t.references :user
    	t.references :order
    	t.time :pickup_time
    	t.time :delivery_time
    	t.integer :payment_status, default: 0
      t.time :reached_time
      t.integer :order_status , default: 0
      t.timestamps
    end
  end
end

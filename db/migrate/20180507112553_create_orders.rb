class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user
      t.string :order_number
      t.float :sub_total
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.text :address_one
      t.text :address_two
      t.string :city
      t.string :state
      t.string :post_code
      t.integer :payment_method
      t.boolean :terms

      t.timestamps
    end
  end
end

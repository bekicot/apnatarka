class AddPaymentReferenceToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :payment_reference, :integer
  end
end

class AddColmnToRider < ActiveRecord::Migration[5.1]
  def change
  	add_column :riders, :reason, :string
  	add_column :riders, :delivery_status, :integer
  end
end

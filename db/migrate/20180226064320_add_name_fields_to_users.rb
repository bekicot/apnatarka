class AddNameFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :cnic, :string
    add_column :users, :role, :integer, default: 1
    add_column :users, :gender, :integer, default: 0
    add_column :users, :status, :integer, default: 0
  end
end

class CreateFranchise < ActiveRecord::Migration[5.1]
  def change
    create_table :franchises do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_number
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end

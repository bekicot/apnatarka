class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.references :user
      t.integer :address_type
      t.string :building_name
      t.string :building_number
      t.string :room_no
      t.string :direction
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end

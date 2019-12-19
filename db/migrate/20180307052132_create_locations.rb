class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string  :phone
      t.string  :postal_code
      t.float :lat
      t.float :lng
      t.timestamps
    end
    reversible do |dir|
      dir.up do
        Location.create_translation_table! title: :string, address: :string, country: :string
      end

      dir.down do
        Location.drop_translation_table!
      end
    end
  end
end

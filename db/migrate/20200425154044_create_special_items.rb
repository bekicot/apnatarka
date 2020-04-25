class CreateSpecialItems < ActiveRecord::Migration[5.1]
  def change
    create_table :special_items do |t|
      t.string :name
      t.integer :quantity
      t.float :price
      t.integer :measurement      
      t.timestamps
    end
  end
end

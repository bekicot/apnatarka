class CreateMessItems < ActiveRecord::Migration[5.1]
  def change
    create_table :mess_items do |t|
    	t.references :chef_category_item
    	t.references :mess
    	t.integer :day, default: 0
    	t.integer :avalible_in, default: 0
      t.timestamps
    end
  end
end

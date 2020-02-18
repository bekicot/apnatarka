class CreateChefAvalibilities < ActiveRecord::Migration[5.1]
  def change
    create_table :chef_avalibilities do |t|
    	t.references :user
    	t.references :chef_category_item
    	t.string :day
      t.timestamps
    end
  end
end

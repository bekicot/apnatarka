class CreateChefCategoryItems < ActiveRecord::Migration[5.1]
  def change
    create_table :chef_category_items do |t|
      t.references :menu_item
      t.references :chef_category
      t.timestamps
    end
  end
end

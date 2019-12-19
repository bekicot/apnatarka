class CreateMenuItems < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_items do |t|
      t.references :category
      t.attachment :avatar
      t.float :price
      t.timestamps
    end
    reversible do |dir|
      dir.up do
        MenuItem.create_translation_table! title: :string, description: :text
      end
      
      dir.down do
        MenuItem.drop_translation_table!
      end
    end
  end
end

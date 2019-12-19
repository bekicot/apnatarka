class CreateMenuLists < ActiveRecord::Migration[5.1]
  def change
    create_table :menu_lists do |t|
      t.attachment :menu_file
      t.timestamps
    end
  end
end

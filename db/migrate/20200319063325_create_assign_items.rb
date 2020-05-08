class CreateAssignItems < ActiveRecord::Migration[5.1]
  def change
    create_table :assign_items do |t|
    	t.references :user
    	t.references :item
      t.references :inventory_item
    	t.float :quantity
    	t.datetime :assign_date
      t.integer :measure, default: 0
      t.references :chef, type: :integer, index: true, null: false, foreign_key: {to_table: :users, on_delete: :cascade}
      t.timestamps
    end
  end
end

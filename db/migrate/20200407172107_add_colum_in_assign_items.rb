class AddColumInAssignItems < ActiveRecord::Migration[5.1]
  def change
  	add_column :assign_items, :status, :integer, default: 0
  end
end

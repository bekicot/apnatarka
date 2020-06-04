class ChnageColumnOfAssignItem < ActiveRecord::Migration[5.1]
  def change
  	change_column :assign_items, :measure, :string
  end
end

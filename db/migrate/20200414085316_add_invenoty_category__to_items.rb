class AddInvenotyCategoryToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :inventory_category, foreign_key: true
  end
end

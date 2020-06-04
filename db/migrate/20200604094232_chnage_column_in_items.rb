class ChnageColumnInItems < ActiveRecord::Migration[5.1]
  def change
  	change_column :items, :measure, :string
  end
end

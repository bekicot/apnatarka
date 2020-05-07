class AddColumnInItems < ActiveRecord::Migration[5.1]
  def change
  	add_column :items, :alert_at, :float
  	add_column :items, :measure, :integer
  end
end

class CreateRiderAmounts < ActiveRecord::Migration[5.1]
  def change
    create_table :rider_amounts do |t|
    	t.references :user
    	t.float :total
      t.timestamps
    end
  end
end

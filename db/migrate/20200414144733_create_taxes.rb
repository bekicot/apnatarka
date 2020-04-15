class CreateTaxes < ActiveRecord::Migration[5.1]
  def change
    create_table :taxes do |t|
    	t.integer :tax
      t.timestamps
    end
  end
end

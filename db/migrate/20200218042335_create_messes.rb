class CreateMesses < ActiveRecord::Migration[5.1]
  def change
    create_table :messes do |t|
    	t.references :user
    	t.string :title
      t.timestamps
    end
  end
end

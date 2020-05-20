class CreateUserMesses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_messes do |t|
    	t.references :mess_item
    	t.references :mess_request
    	t.boolean :is_checked
      t.timestamps
    end
  end
end

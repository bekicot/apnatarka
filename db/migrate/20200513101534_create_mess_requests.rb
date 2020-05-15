class CreateMessRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :mess_requests do |t|
    	t.references :user
    	t.references :mess
    	t.references :chef, type: :integer, index: true, null: false, foreign_key: {to_table: :users, on_delete: :cascade}
    	t.integer :status
      t.timestamps
    end
  end
end

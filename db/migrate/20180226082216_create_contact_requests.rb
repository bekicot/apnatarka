class CreateContactRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_requests do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text   :message
      t.timestamps
    end
  end
end

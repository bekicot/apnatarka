class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.string :name
      t.string :mobile_number
      t.string :email
      t.integer :gender
      t.integer :profession
      t.integer :hear_through
      t.string :hear_through_other
      t.integer :preference
      t.integer :experience
      t.integer :contact_through
      t.text :comments

      t.timestamps
    end
  end
end

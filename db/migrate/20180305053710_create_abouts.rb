class CreateAbouts < ActiveRecord::Migration[5.1]
  def change
    create_table :abouts do |t|
      t.boolean :is_active, default: false
      t.timestamps
    end
    reversible do |dir|
      dir.up do
        About.create_translation_table! heading: :string, description: :text
      end

      dir.down do
        About.drop_translation_table!
      end
    end
  end
end

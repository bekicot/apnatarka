class AddFavoriteToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :is_favorite, :boolean, default: false
  end
end

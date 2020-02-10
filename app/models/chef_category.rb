class ChefCategory < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :chef_category_items, dependent: :destroy
	has_many :menu_items, through: :chef_category_items
end

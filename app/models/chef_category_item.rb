class ChefCategoryItem < ApplicationRecord
	belongs_to :chef_category
	belongs_to :menu_item
	has_many :chef_avalibilities
	has_many :mess_items
end

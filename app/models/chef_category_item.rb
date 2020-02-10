class ChefCategoryItem < ApplicationRecord
	belongs_to :chef_category
	belongs_to :menu_item
end

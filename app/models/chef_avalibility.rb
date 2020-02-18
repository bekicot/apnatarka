class ChefAvalibility < ApplicationRecord
	belongs_to :user
	belongs_to :chef_category_item
end

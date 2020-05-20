class ItemChefsController < ApplicationController
	def index
		chef_category = ChefCategory.find(params[:menu_id])
		@chef_category_items = chef_category.chef_category_items
		# @menu_item = MenuItem.find(params[:menu_id])
		# @chef_category_items = @menu_item.chef_category_items
	end
end

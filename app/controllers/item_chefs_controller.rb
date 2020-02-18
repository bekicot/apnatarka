class ItemChefsController < ApplicationController

	def index
		@menu_item = MenuItem.find(params[:menu_id])
		@category = @menu_item.category
		@category_chef = @category.chefs
	end
end

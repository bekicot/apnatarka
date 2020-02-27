class ItemChefsController < ApplicationController
	def index
		@menu_item = MenuItem.find(params[:menu_id])
		@chef_category_items = @menu_item.chef_category_items
	end
end

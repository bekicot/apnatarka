class ItemChefsController < ApplicationController
	def index
		chef_category = ChefCategory.find(params[:menu_id])
		@chef_category_items = chef_category.chef_category_items
		# @menu_item = MenuItem.find(params[:menu_id])
		# @chef_category_items = @menu_item.chef_category_items
		# add_to_cart_delivery_index_path(chef_menu_item: item)
	end

	def check_chef
		@current_chef_id = ChefCategoryItem.find(params[:chef_menu_item]).chef_category.user.id
		@chef_menu = params[:chef_menu_item]
	    if session[:cart].present?
      	@chef_menu_item_ids = session[:cart].keys.map {|key| ChefCategoryItem.get_item_from_cart(key) }
	      chef_cat_id = session[:cart].first.first.split('_')[3]
	      @chef_id = ChefCategoryItem.find(chef_cat_id).chef_category.user.id
	      if !@chef_menu_item_ids.include? @chef_menu
		      if @current_chef_id == @chef_id
		     		redirect_to add_to_cart_delivery_index_path(chef_menu_item: params[:chef_menu_item]) 	
		      end
		    end
	    else
	     	redirect_to add_to_cart_delivery_index_path(chef_menu_item: params[:chef_menu_item]) 	
	    end
	end

	def remove_cart_item
		session.delete('cart')
		redirect_to add_to_cart_delivery_index_path(chef_menu_item: params[:chef_menu_item])
	end
end

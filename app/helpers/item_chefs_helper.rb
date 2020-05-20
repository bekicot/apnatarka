module ItemChefsHelper

	def break_fast(today_mess)
		today_mess&.where(avalible_in: "break_fast")&.first&.chef_category_item&.menu_item&.title || "N/A"
	end

	def lunch(today_mess)
		today_mess&.where(avalible_in: "lunch")&.first&.chef_category_item&.menu_item&.title || "N/A"
	end

	def dinner(today_mess)
		today_mess&.where(avalible_in: "dinner")&.first&.chef_category_item&.menu_item&.title || "N/A"
	end

	def customer_order_items(order)
		chef_ids = order.order_items.map{|x| x.chef_category_item_id }
    menu_ids = ChefCategoryItem.where(id: chef_ids).map{|x| x.menu_item_id }
    MenuItem.where(id: menu_ids).map(&:title).join(", ")
	end

	def customer_special_items(order)
		if order.order_special_items.present?
			special = order.order_special_items.map{|x|x.special_item_id}
	    SpecialItem.where(id: special).map(&:name).join(", ")
	  else
	  	"N/A"
	  end
	end
end

module Admin::ItemsHelper

	def inventory_remaining_quantity(item)
		if item.inventory_item_record.present?
			total = item.inventory_item_record&.total_quantity
			used = item.inventory_item_record&.used_quantity
			used.present? ? total - used : total 
		end
	end

	def chef_name_and_contact(order_item)
		"#{order_item.chef_category_item.chef_category.user.first_name} (#{order_item.chef_category_item.chef_category.user.phone})"
	end
end

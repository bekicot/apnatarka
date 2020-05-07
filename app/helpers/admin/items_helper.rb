module Admin::ItemsHelper

	def inventory_remaining_quantity(item)
		if item.inventory_item_record.present?
			total = item.inventory_item_record&.total_quantity
			used = item.inventory_item_record&.used_quantity
			used.present? ? total - used : total 
		end
	end
end

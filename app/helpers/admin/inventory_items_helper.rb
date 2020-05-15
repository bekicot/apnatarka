module Admin::InventoryItemsHelper
	def item_name(item)
		Item.find_by(id: item ).title
	end

	def max_quantity_value(item)
		used = item.item&.inventory_item_record&.used_quantity
		total = item.item&.inventory_item_record&.total_quantity
		if used.present? && total.present?
		item.item&.inventory_item_record&.total_quantity - item.item&.inventory_item_record&.used_quantity
		elsif total.present?
			item.item&.inventory_item_record&.total_quantity
		else
			0
		end 
	end

	def order_status(order)
		order_items = order.order_items.map{|x| x.item_status if x.item_status == "pending"}
		order_items.any? ? "Pending" : "Accept"
	end
end

module Admin::InventoryItemsHelper
	def item_name(item)
		InventoryItem.find_by(id: item ).item.title
	end
end

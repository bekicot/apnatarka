module Customer::OrderHistoriesHelper

  def order_item_names(order)
    chef_category_item_ids = order.order_items.map(&:chef_category_item_id)
    menu_item_ids = ChefCategoryItem.where(id: chef_category_item_ids).map(&:menu_item_id)
    menu_item_titles = MenuItem.where(id: menu_item_ids).map(&:title)
    menu_item_titles.join(', ')
  end

  def order_special_items(order)
  	special_items_ids = order.order_special_items.map(&:special_item_id)
  	special_items_names = SpecialItem.where(id: special_items_ids).map(&:name)
  	special_items_names.join(', ')
  end
end

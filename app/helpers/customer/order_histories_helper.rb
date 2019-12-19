module Customer::OrderHistoriesHelper

  def order_item_names(order)
    menu_item_ids = order.order_items.map(&:menu_item_id)
    menu_item_titles = MenuItem.where(id: menu_item_ids).map(&:title)
    menu_item_titles.join(', ')
  end
end

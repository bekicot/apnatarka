module MenuHelper

  def item_in_cart?(menu_item)
    session[:cart].present? && session[:cart].keys.include?(MenuItem.item_key_for_cart(menu_item))
  end
end

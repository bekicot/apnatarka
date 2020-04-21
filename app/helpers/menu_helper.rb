module MenuHelper

  def item_in_cart?(menu_item)
    session[:cart].present? && session[:cart].keys.include?(MenuItem.item_key_for_cart(menu_item))
  end

  def check_chef_avalibility(menu_item)
  	menu_item&.chef_category_items.includes(:chef_avalibilities)&.map{ |item| item&.chef_avalibilities.where(day: Time.now.strftime("%A")).first}.any?
  end
end

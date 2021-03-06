module MenuHelper

  def item_in_cart?(menu_item)
    session[:cart].present? && session[:cart].keys.include?(MenuItem.item_key_for_cart(menu_item))
  end

  def check_chef_avalibility(menu_item)
  	# chef.user.chef_avalibilities.where(day: Time.now.strftime("%A")).any?
    chef_cat_ids = menu_item.chef_category_items.map{|x| x.id }
    ChefAvalibility.where(chef_category_item_id: chef_cat_ids).where(day: Time.now.strftime("%A")).any?

  	# menu_item&.chef_category_items.includes(:chef_avalibilities)&.map{ |item| item&.chef_avalibilities.where(day: Time.now.strftime("%A")).first}.any?
  end

  def chef_item_avalibility(item)
  	item.chef_avalibilities.where(day: Time.now.strftime("%A")).first.present?
  end

  def check_chefs(menu_items)
    ids = menu_items.map{|x| x.id }
    chef_item_ids = ChefCategoryItem.where(menu_item_id: ids)
    ChefAvalibility.where(chef_category_item_id: chef_item_ids).where(day: Time.now.strftime("%A")).any?
  end
end

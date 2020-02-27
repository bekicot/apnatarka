class ChefCategoryItem < ApplicationRecord
	belongs_to :chef_category
	belongs_to :menu_item
	has_many :chef_avalibilities
	has_many :mess_items

	@@cart_joiner = "chef_menu_item_"
  	@@quantity    = 1

	def self.item_to_add_in_cart(menu_item, quantity=nil)
    if quantity.nil?
      {"#{@@cart_joiner}#{menu_item}" => @@quantity}
    else
      {"#{@@cart_joiner}#{menu_item}" => quantity}
    end
	end

	def self.get_item_from_cart(key)
    key.sub(@@cart_joiner, '')
  end

  def self.item_key_for_cart(chef_menu_item)
    "#{@@cart_joiner}#{chef_menu_item}"
  end

  def self.special_request_to_add_in_cart(chef_menu_item, message)
    {"#{@@cart_joiner}#{chef_menu_item}" => message}
  end

  def self.special_request(order_item)
    if order_item.present? && order_item.special_request.present?
      order_item.special_request
    else
      "N/A"
    end
  end
end

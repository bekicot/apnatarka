class SpecialItem < ApplicationRecord
	has_many :order_special_items

	@@special_item_joiner = "special_item_"

	def self.add_special_item(special_item, quantity)
		{"#{@@special_item_joiner}#{special_item}" => quantity}
	end

	def self.get_item_from_special_item(key)
    	key.sub(@@special_item_joiner, '')
  	end

  	def self.item_key_for_cart(special_item)
    	"#{@@special_item_joiner}#{special_item}"
  	end
end

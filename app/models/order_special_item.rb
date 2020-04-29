class OrderSpecialItem < ApplicationRecord
	belongs_to :order
	belongs_to :special_item
end

class Item < ApplicationRecord
	has_many :inventroy_items, dependent: :destroy
	belongs_to :inventory_category
end

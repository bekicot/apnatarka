class Item < ApplicationRecord
	has_many :inventroy_items, dependent: :destroy
end

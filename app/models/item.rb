class Item < ApplicationRecord
	has_one :inventroy_items, dependent: :destroy
end

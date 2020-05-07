class Item < ApplicationRecord
	has_many :inventroy_items, dependent: :destroy
	has_one :inventory_item_record, dependent: :destroy
	belongs_to :inventory_category

	enum measure: [ :litter, :kg, :ml, :gram, :no_measure ]
end

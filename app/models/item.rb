class Item < ApplicationRecord
	has_many :inventroy_items, dependent: :destroy
	has_one :inventory_item_record, dependent: :destroy
	belongs_to :inventory_category
	has_many :assign_items

	enum measure: [ :litter, :kg, :ml, :gram, :pack, :piece, :no_measure ]
end

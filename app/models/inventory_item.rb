class InventoryItem < ApplicationRecord
	belongs_to :item
	enum measure: [ :ltr, :kg ]
end

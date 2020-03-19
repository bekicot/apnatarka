class InventoryItem < ApplicationRecord
	belongs_to :item
	has_many :assign_items
	enum measure: [ :litter, :kg ]
	extend FriendlyId
	friendly_id :measure, use: :slugged

end

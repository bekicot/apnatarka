class InventoryItem < ApplicationRecord
	belongs_to :item
	has_many :assign_items
	enum measure: [ :litter, :kg, :ml, :gram, :no_measure ]
	extend FriendlyId
	friendly_id :measure, use: :slugged

end

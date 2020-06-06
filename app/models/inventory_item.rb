class InventoryItem < ApplicationRecord
	belongs_to :item
	has_many :assign_items
	accepts_nested_attributes_for :assign_items, reject_if: :all_blank, allow_destroy: true
	# enum measure: [ :litter, :kg, :ml, :gram, :pack, :piece, :no_measure ]
	extend FriendlyId
	friendly_id :measure, use: :slugged

end

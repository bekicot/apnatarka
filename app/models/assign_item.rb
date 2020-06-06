class AssignItem < ApplicationRecord
	belongs_to :user
	belongs_to :item
	belongs_to :inventory_item, optional: true
	belongs_to :chef, class_name: 'User', foreign_key: 'chef_id'
	# enum measure: [ :litter, :kg, :ml, :gram, :pack, :piece, :no_measure ]
	enum status: [:enough_stock, :limited_stock, :out_of_stock ]
end

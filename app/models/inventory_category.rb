class InventoryCategory < ApplicationRecord
	has_many :items, dependent: :destroy
end

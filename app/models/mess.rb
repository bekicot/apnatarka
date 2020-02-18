class Mess < ApplicationRecord
	has_many :mess_items
	belongs_to :user
end

class Mess < ApplicationRecord
	has_many :mess_items
	belongs_to :user
	has_many :mess_requests
	accepts_nested_attributes_for :mess_items, reject_if: :all_blank, allow_destroy: true
end

class Rider < ApplicationRecord
	belongs_to :user
	belongs_to :order
	enum payment_status: [:cash_on_delivery, :receive]
end

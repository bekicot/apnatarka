class Rider < ApplicationRecord
	belongs_to :user
	belongs_to :order
	has_many :rider_amounts
	enum payment_status: [:cash_on_delivery, :receive]
	enum order_status: [:pending, :accept, :reject, :deliver]
	enum delivery_status: [:late, :on_time]
end

class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :chef_category_item

  enum item_status: [:pending, :accept, :reject, :ready, :given_to_rider]
end

class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :chef_category_item
end

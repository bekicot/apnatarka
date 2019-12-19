class Address < ApplicationRecord

  belongs_to :user, optional: true
  has_many :orders

  enum address_type: [:home, :apartment, :office]
end

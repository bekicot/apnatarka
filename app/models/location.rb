class Location < ApplicationRecord
	translates :title, :address, :country
  globalize_accessors attributes: [:title, :address, :country]

  default_scope { includes(:translations) }

  has_many :orders
end

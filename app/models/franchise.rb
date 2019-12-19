class Franchise < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :phone_number, :city, :country
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end

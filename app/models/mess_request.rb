class MessRequest < ApplicationRecord
	belongs_to :user
	belongs_to :mess
  	has_many :user_messes
	belongs_to :chef, class_name: 'User', foreign_key: 'chef_id'
	enum status: [:pending, :approve]
end

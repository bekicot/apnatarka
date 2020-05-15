class MessItem < ApplicationRecord
	belongs_to :mess
	belongs_to :chef_category_item
	has_many :user_messes
	enum day: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
	enum avalible_in: [:break_fast, :lunch, :dinner]
end

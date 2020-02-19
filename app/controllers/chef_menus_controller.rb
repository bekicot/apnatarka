class ChefMenusController < ApplicationController

	def index
		@chefs = User.chef
	end
end

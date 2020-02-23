class ChefMenusController < ApplicationController
  before_action :find_chef, only: [:chef_mess_items]

  def index
    @chefs = User.chef
  end

  def chef_mess_items
    @mess_items = @chef.mess_items
  end

  private
  def find_chef
    @chef = User.find(params[:id])
  end
end

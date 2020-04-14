class Admin::ChefMenusController < Admin::BaseController
	before_action :find_user, only: [:chef_menu_items, :new]
  def index
  	@users = User.chef
  end

  def chef_menu_items
  	@chef_categories = @user.chef_categories
  end

  def new 
  	@chef_category_item = ChefCategoryItem.find(params[:chef_category_item]).id
  	@days = Date::DAYNAMES
  	@chef_avalibility = ChefAvalibility.new
  	respond_to do |format|
      format.js
    end
  end

  def create
  	params[:chef_avalibility][:day].reject(&:empty?).each do |day|
        @chef_avalibility = ChefAvalibility.find_or_create_by(day: day, chef_category_item_id: params[:chef_avalibility][:chef_category_item_id], user_id: params[:chef_avalibility][:user_id] )
    end
    flash[:success] = "You Have Added Avalibility Successfullly"
    redirect_to chef_menu_items_admin_chef_menu_path(params[:chef_avalibility][:user_id])
  end

  private
  def find_user
  	@user = User.find(params[:id])
  end
end

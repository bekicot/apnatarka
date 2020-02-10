class Admin::ChefCategoryItemsController < Admin::BaseController
  before_action :find_user
  before_action :find_chef_category

  def new
    @items = MenuItem.all
    @selected_items = @chef_category.menu_items
    @chef_category_item = @chef_category.chef_category_items.new 
    respond_to do |format|
      format.js
    end
  end

  def create
    updated_ids = params[:chef_category_item][:menu_item_id].reject(&:empty?)
    old_ids = @chef_category.chef_category_items.pluck(:menu_item_id)
    deleted_ids = old_ids.map{|id| id unless updated_ids.include? id.to_s}.compact
    @chef_category.chef_category_items.where(menu_item_id: deleted_ids).destroy_all
    params[:chef_category_item][:menu_item_id].reject(&:empty?).each do |menu_item_id|
        @chef_category.chef_category_items.find_or_create_by!(menu_item_id: menu_item_id)
    end
    flash[:success] = "You Have Added Items Successfullly"
    redirect_to admin_user_chef_categories_path(@chef)
  end

  private

  def find_user
    @chef = User.find_by(id: params[:user_id])
  end

  def find_chef_category
    @chef_category = ChefCategory.find_by(id: params[:chef_category_id])
  end
end

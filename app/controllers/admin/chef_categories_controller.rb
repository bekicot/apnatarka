class Admin::ChefCategoriesController < Admin::BaseController
  before_action :find_user

  def index
      @chef_categories = @chef.chef_categories.includes(:chef_category_items)
  end

  def new
      @categories = Category.where.not(id: @chef.categories)
      @chef_category = @chef.chef_categories.new
      respond_to do |format|
          format.js
      end
  end

  def create
    params[:chef_category][:category_id].reject(&:empty?).each do |category_id|
        @chef.chef_categories.find_or_create_by!(category_id: category_id)
    end
    flash[:success] = "You Have Added Categories Successfullly"
    redirect_to admin_user_chef_categories_path(@chef)
  end

  def destroy
    find_chef_category
    if @chef_category.destroy
      flash[:success] = "You Havey Removed Categories Successfullly"
    else
      flash[:alert] = "Something Went Wrong"
    end  
      redirect_to admin_user_chef_categories_path(@chef)
  end

  private

  def find_chef_category
    @chef_category = ChefCategory.find_by(id: params[:id])
  end

  def find_user
      @chef = User.find_by(id: params[:user_id])
  end
end

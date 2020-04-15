class Admin::InventoryCategoriesController < Admin::BaseController
  before_action :find_category, only: [:edit, :update, :destroy]
  def index
  	@iventory_categories = InventoryCategory.all.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def new
  	@inventory_category = InventoryCategory.new
  	respond_to do |format|
      format.js
    end
  end

  def create
    @inventory_category = InventoryCategory.new(category_params)
    if @inventory_category.save
      flash[:success] = "You Have Add Category Sucessfully"
    	redirect_to admin_inventory_categories_path
    else
    	render :back
    end
  end

  def edit
  end

  def update
    if @inventory_category.update(category_params)
      flash[:success] = "You Have Updated Category Sucessfully"
      redirect_to admin_inventory_categories_path
    else
      render :back
    end
  end

  def destroy
    if @inventory_category.destroy
      flash[:success] = "You Have Deleted Category Sucessfully"
      redirect_to admin_inventory_categories_path
    end
  end

  private
  def category_params
  	params.require(:inventory_category).permit(:title)
  end

  def find_category
  	@inventory_category = InventoryCategory.find(params[:id])
  end
end

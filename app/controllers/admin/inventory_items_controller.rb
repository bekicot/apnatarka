class Admin::InventoryItemsController < Admin::BaseController
  before_action :find_inventroy_item, only: [:edit, :update, :destroy, :assign_item, :view_item_detail]
  before_action :find_item, only: [:new, :edit, :append_inventory_item]

  def index
    @inventroy_items = InventoryItem.where('extract(year from indate) = ? AND extract(month from indate) = ?',
                       Date.today.year, Date.today.month).order('created_at DESC')
                      .paginate(page: params[:page], per_page: 10)
  end
  def new 
    @inventroy_item = InventoryItem.new
  end

  def create
    @inventroy_item = InventoryItem.new(inventory_item_params)
    if @inventroy_item.save
      flash[:success] = "You Have Add Inventory Item Sucessfully"
    end
    redirect_to admin_inventory_items_path
  end

  def change_status
    @inventroy_item = InventoryItem.find(params[:id])
    @inventroy_item.update_attribute(:used, params[:inventory_item][:used])
    redirect_to admin_inventory_items_path
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @inventroy_item.update(inventory_item_params)
      flash[:success] = "You Have Updated Inventory Item Sucessfully"
      redirect_to admin_inventory_items_path
    else
      render :back
    end
  end

  def destroy
    if @inventory_item.destroy
      flash[:success] = "You Have Deleted Inventory Item Sucessfully"
      redirect_to admin_inventory_items_path
    end
  end

  def assign_item
    @chefs = User.chef
    @assign_item = AssignItem.new
  end

  def save_assign_item
    @assign_item = AssignItem.new(assign_item_params)
    if @assign_item.save
      flash[:success] = "You Have Assign Inventory Item Sucessfully"
      redirect_to admin_inventory_items_path
    else
      render :back
    end
  end

  def view_item_detail
    @assign_items = @inventroy_item.assign_items
  end

  def append_inventory_item
    respond_to do |format|
      format.js
    end
  end

  def inventory_by_year
    @inventroy_items = InventoryItem.where('extract(year from indate) = ? AND extract(month from indate) = ?',
                        params[:year], params[:month]).order('created_at DESC')
                        .paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.js
    end
  end


  private

  def inventory_item_params
    params.require(:inventory_item).permit(:item_id, :price, :quantity, :measure, :indate)
  end

  def find_inventroy_item
    @inventroy_item = InventoryItem.friendly.find(params[:id])
  end

  def find_item
    @items = Item.all
  end

  def assign_item_params
    params.require(:assign_item).permit(:inventory_item_id, :quantity, :assign_date, :user_id, :measure, :chef_id)
  end
end
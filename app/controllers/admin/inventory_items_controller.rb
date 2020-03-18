class Admin::InventoryItemsController < Admin::BaseController
  before_action :find_inventroy_item, only: [:edit, :update, :destroy]

  def index
    @inventroy_items = InventoryItem.all
  end
  def new 
    @inventroy_item = InventoryItem.new
    @items = Item.all
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
    @items = Item.all
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


  private

  def inventory_item_params
    params.require(:inventory_item).permit(:item_id, :price, :quantity, :measure, :indate)
  end
  def find_inventroy_item
    @inventroy_item = InventoryItem.find(params[:id])
  end
end

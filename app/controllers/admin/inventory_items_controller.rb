class Admin::InventoryItemsController < Admin::BaseController
  before_action :find_inventroy_item, only: [:edit, :update, :destroy, :view_item_detail]
  before_action :find_item, only: [:new, :edit, :append_inventory_item]
  before_action :find_inventory, only: [:new, :edit, :append_inventory_item]

  def index
    @inventroy_items = InventoryItem.where('extract(year from indate) = ? AND extract(month from indate) = ?',
                       Date.today.year, Date.today.month).order('created_at DESC')
                      .paginate(page: params[:page], per_page: 10)
  end
  
  def new 
    @inventroy_item = InventoryItem.new
    @inventroy_item.assign_items.build
  end

  def create
    @inventroy_items = []
    item_record = InventoryItemRecord.where(item_id: params[:inventory_item][:item_id])
    if item_record.present?
      total = item_record.first.total_quantity + params[:inventory_item][:stock_quantity].to_i
      item_record.first.update_attribute(:total_quantity, total )
    else
      InventoryItemRecord.create(item_id: params[:inventory_item][:item_id], total_quantity: params[:inventory_item][:stock_quantity])
    end
    @inventroy_item = InventoryItem.create(inventory_item_params)
    if params[:inventry].present?
      params[:inventry].each do |k,v|
        record = InventoryItemRecord.where(item_id: v[:item_id])
        if record.present?
          amount = record.first.total_quantity + v[:stock_quantity].to_f
          record.first.update_attribute(:total_quantity, amount)
        else
          InventoryItemRecord.create(item_id: v[:item_id], total_quantity: v[:stock_quantity])
        end
        @inventroy_items << InventoryItem.new( item_id: v[:item_id], price: v[:price], quantity: v[:quantity],
              indate: params[:inventory_item][:indate], measure: v[:measure], stock_quantity: v[:stock_quantity],
              total_price: v[:total_price], discount: v[:discount], total_expense: v[:total_expense])
      end
      InventoryItem.import @inventroy_items
    end
      flash[:success] = "You Have Add Inventory Items Sucessfully"
      redirect_to admin_inventory_items_path
  end

  def save_assign_item
    @assign_items = []
    params[:assign_item].each do |item|
      if item[:quantity].present? && item[:quantity].to_f != 0
        item_record = InventoryItemRecord.where(item_id: item[:item_id])
        if item_record.present?
          quantity = item_record.first.used_quantity.to_f + item[:quantity].to_f
          item_record.first.update_attribute(:used_quantity, quantity)
          @assign_items << AssignItem.new(chef_id: params[:chef_id], assign_date: params[:assign_date],
            item_id: item[:item_id], quantity: item[:quantity], measure: item[:measure], user_id: current_user.id)
        end
      end
    end
    AssignItem.import @assign_items
    flash[:success] = "You Have Assign Inventory Item Sucessfully"
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
    if @inventroy_item.destroy
      flash[:success] = "You Have Deleted Inventory Item Sucessfully"
      redirect_to admin_inventory_items_path
    end
  end

  def assign_item
    @items = Item.all
    @chefs = User.chef
    @assign_items = []
    @items.each do |item|
      @assign_items << AssignItem.new(item_id: item.id)
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
    params.require(:inventory_item).permit(:item_id, :price, :quantity, :measure, :indate,
                                 :stock_quantity, :total_price, :discount, :total_expense)
  end

  def find_inventroy_item
    @inventroy_item = InventoryItem.friendly.find(params[:id])
  end

  def find_item
    @items = Item.all
  end

  def find_inventory
    @inventory_items = InventoryItem.all
  end

  def assign_item_params
    params.require(:assign_item).permit(:inventory_item_id, :quantity, :assign_date, :user_id, :measure, :chef_id)
  end
end

class Admin::ItemsController < Admin::BaseController
  before_action :find_item, only: [:edit, :update, :destroy]
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "You Have Add Item Sucessfully"
    end
    redirect_to admin_items_path
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @item.update(item_params)
      flash[:success] = "You Have Updated Item Sucessfully"
      redirect_to admin_items_path
    else
      render :back
    end
  end

  def destroy
    if @item.destroy
      flash[:success] = "You Have Deleted Item Sucessfully"
      redirect_to admin_items_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:title)
  end

  def find_item
    @item = Item.find(params[:id])
  end
end

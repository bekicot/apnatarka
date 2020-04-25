class Admin::SpecialItemsController < Admin::BaseController
  before_action :find_special_item, only: [:show, :destroy, :edit, :update]


  def index
    @special_items = SpecialItem.all
  end

  def new
    @special_item = SpecialItem.new()
  end

  def create
    @special_item = SpecialItem.new(special_item_prams)
    if @special_item.save!
      flash[:success] = "#{@special_item.name} Created Successfully"
      redirect_to admin_special_items_path
    else
      render 'new'
    end
  end

  def edit
    
  end

  def update
    if @special_item.update(special_item_prams)
      flash[:success] = "#{@special_item.name} Updated Successfully"
      redirect_to admin_special_items_path
    else
      render 'edit'
    end
  end

  def destroy
    if @special_item.destroy
      flash[:success] = "#{@special_item.name} Deleted Successfully"
    else
      flash[:notice] = "Something went wrong #{@special_item.name} Item"
    end
      redirect_to admin_special_items_path
  end

  private

  def find_special_item
    @special_item = SpecialItem.find_by_id(params[:id])    
  end

  def special_item_prams
    params.require(:special_item).permit(:name, :measurement, :price, :quantity)
  end

end

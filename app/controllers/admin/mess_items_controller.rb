class Admin::MessItemsController < Admin::BaseController
  before_action :find_mess, only: [:index, :new, :edit]
  before_action :find_mess_item, only: [:edit, :destroy, :update]
  before_action :days_avaliblty_chef_categories, only: [:new, :edit]
  def index
    @mess_items = @mess.mess_items
  end

  def new
    @mess_item = MessItem.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @mess_item = MessItem.new(mess_item_params)
    if @mess_item.save
      flash[:success] = "You Have Added Mess Item Successfullly"
      redirect_to admin_mess_items_path(mess_id: params[:mess_item][:mess_id])
    else
      flash[:alert] = "Something Went Wrong Try Again"
      render :back
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @mess_item.update(mess_item_params) 
      flash[:success] = "You Have Updated Mess Item Successfullly"
      redirect_to admin_mess_items_path(mess_id: params[:mess_item][:mess_id])
    else
      flash[:alert] = "Something Went Wrong Try Again"
      render :back
    end
  end

  def destroy
    @mess = @mess_item.mess_id
    if @mess_item.destroy
      flash[:success] = "You Have Deleted Mess Item Successfullly"
    end
    redirect_to admin_mess_items_path(mess_id: @mess)
  end

  private

  def find_mess
    @mess = Mess.find(params[:mess_id])
  end

  def find_mess_item
    @mess_item = MessItem.find(params[:id])
  end

  def mess_item_params
    params.require(:mess_item).permit(:chef_category_item_id, :day, :avalible_in, :mess_id, :price)
  end

  def days_avaliblty_chef_categories
    @chef_categories = @mess.user.chef_category_items
    @days = MessItem.days
    @avalible_in = MessItem.avalible_ins
  end
end

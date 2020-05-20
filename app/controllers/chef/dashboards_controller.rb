class Chef::DashboardsController < Chef::BaseController
  before_action :check_chef
  skip_before_action :verify_authenticity_token, only: [:change_order_status, :change_assigned_item_status]
  before_action :find_order, only: [:show, :change_order_status]
  before_action :find_chef_order, only: [:index, :order_by_date, :show, :change_order_status]
  def index
    @chef_order_items = OrderItem.where("created_at::date = ? ", Date.today).where(chef_category_item_id: @chef_category_item_ids).includes(:order).order('created_at DESC').paginate(page: params[:page], per_page: 10)
    # @chef_category_items = @chef.chef_category_items.includes(order_items: [:order]).order('created_at DESC').paginate(page: params[:page], per_page: 10)
    # @order_items = @chef.chef_category_items.map{|x| x.order_items}
  end

  def chef_inventory
    @chef_items = AssignItem.where(chef_id: @chef.id).includes(:item).order('created_at DESC').paginate(page: params[:item_page], per_page: 10)
  end

  def order_by_date
    @chef_order_items = OrderItem.where("created_at::date = ? ", params[:date]).where(chef_category_item_id: @chef_category_item_ids).includes(:order).order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def inventory_by_date
    @chef_items = AssignItem.where(chef_id: @chef.id).where("assign_date::date = ? ", params[:date]).includes(inventory_item: [:item]).order('created_at DESC').paginate(page: params[:item_page], per_page: 10)
  end

  def change_order_status
    chef_items = @order.order_items.where(chef_category_item_id: @chef_category_item_ids)
  	chef_items.update_all(item_status: params[:order_item][:item_status])
    flash[:success] = "Order Status Has Been Changed"
  	redirect_to chef_dashboards_path
  end

  def show
  	@order_items = @order.order_items.where(chef_category_item_id: @chef_category_item_ids)
    @rider_detail = @order.rider
    @special_items = @order.order_special_items
  end

  def change_assigned_item_status
    assign_item = AssignItem.find(params[:id])
    assign_item.update_attribute(:status, params[:assign_item][:status])
    flash[:success] = "Item Status Has Been Changed to #{assign_item.status}"
    redirect_to chef_dashboards_path
  end

  private

  def check_chef
    @chef = current_user
  end

  def find_order
  	@order = Order.find(params[:id])
  end

  def find_chef_order
    chef_category_ids = @chef.chef_categories.map{|x| x.id}
    @chef_category_item_ids = ChefCategoryItem.where(chef_category_id: chef_category_ids).map{|x| x.id}
  end
end

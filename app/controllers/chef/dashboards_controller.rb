class Chef::DashboardsController < Chef::BaseController
  before_action :check_chef
  skip_before_action :verify_authenticity_token, only: [:change_order_status, :change_assigned_item_status]
  before_action :find_order, only: [:show, :change_order_status]
  def index
    @chef_category_items = @chef.chef_category_items.includes(order_items: [:order]).order('created_at DESC').paginate(page: params[:page], per_page: 5)
    @chef_items = AssignItem.where(chef_id: @chef.id).includes(inventory_item: [:item]).order('created_at DESC').paginate(page: params[:oitem_page], per_page: 5)
  end

  def change_order_status
  	@order.update_attribute(:order_status, params[:order][:order_status])
    flash[:success] = "Order Status Has Been Changed to #{@order.order_status}"
  	redirect_to chef_dashboards_path
  end

  def show
  	@order_items = @order.order_items
    @rider_detail = @order.rider
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
end

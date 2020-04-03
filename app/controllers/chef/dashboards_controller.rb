class Chef::DashboardsController < Chef::BaseController
  before_action :check_chef
  skip_before_action :verify_authenticity_token, only: [:change_order_status]
  before_action :find_order, only: [:show, :change_order_status]
  def index
    @chef_category_items = @chef.chef_category_items.includes(order_items: [:order])
  end

  def change_order_status
  	@order.update_attribute(:order_status, params[:order][:order_status])
  	redirect_to chef_dashboards_path
  end

  def show
  	@order_items = @order.order_items
  end

  private

  def check_chef
    @chef = current_user
  end

  def find_order
  	@order = Order.find(params[:id])
  end
end

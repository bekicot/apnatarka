class Admin::OrderHistoriesController < Admin::BaseController
  before_action :check_admin_moderator_user, only: [:index]

  def index
    @orders = Order.includes(:order_items).where(user_id: current_user.id).paginate(page: params[:page], per_page: 10)
  end

  def show
    @order = Order.includes(order_items: [:menu_item]).find(params[:id])
  end

  def customer_orders
    @reg_orders = Order.registered_orders.where.not(user_id: current_user.id).order('created_at DESC').paginate(page: params[:reg_page], per_page: 5)
    @guest_orders = Order.guest_orders.order('created_at DESC').paginate(page: params[:guest_page], per_page: 5)
  end

  def change_status
    order = Order.find(params[:id])
    order.update_attribute(:status, params[:order][:status])
    redirect_to customer_orders_admin_order_histories_path
  end
end

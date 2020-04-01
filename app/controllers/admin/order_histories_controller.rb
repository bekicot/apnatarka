class Admin::OrderHistoriesController < Admin::BaseController
  before_action :check_admin_moderator_user, only: [:index]

  def index
    @orders = Order.includes(:order_items).where(user_id: current_user.id).paginate(page: params[:page], per_page: 10)
  end

  def show
    @rider = Rider.new
    @riders = User.rider
    @order = Order.includes(order_items: [:chef_category_item]).find(params[:id])
    @rider = @order.rider
  end

  def customer_orders
    @reg_orders = Order.registered_orders.where.not(user_id: current_user.id).order('created_at DESC').paginate(page: params[:reg_page], per_page: 5)
    @guest_orders = Order.guest_orders.order('created_at DESC').paginate(page: params[:guest_page], per_page: 5)
    @from_branch_orders = Order.from_branch_orders.order('created_at DESC').paginate(page: params[:guest_page], per_page: 5)
  end

  def change_status
    order = Order.find(params[:id])
    if order.rider.present?
      order.rider.destroy
    end
      order.update_attribute(:status, params[:order][:status])
      Rider.create(rider_params)
    redirect_to customer_orders_admin_order_histories_path
  end

  def rider_payment_status
    rider = Rider.find(params[:id])
    order = rider.order
    if params[:rider][:payment_status] == "receive"
      rider.update_attribute(:payment_status, params[:rider][:payment_status])
      order.update_attribute(:status, "paid")
    else
      rider.update_attribute(:payment_status, params[:rider][:payment_status])
    end
    redirect_to customer_orders_admin_order_histories_path
  end


  private

  def rider_params
    params.require(:order).require(:rider).permit(:user_id, :order_id, :pickup_time, :delivery_time)
  end
end

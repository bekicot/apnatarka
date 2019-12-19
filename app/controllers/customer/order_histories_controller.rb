class Customer::OrderHistoriesController < Customer::BaseController

  def index
    @orders = Order.includes(:order_items).where(user_id: current_user.id)
  end

  def show
    @order = Order.includes(order_items: [:menu_item]).find(params[:id])
  end

end

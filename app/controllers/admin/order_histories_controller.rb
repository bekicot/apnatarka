class Admin::OrderHistoriesController < Admin::BaseController
  before_action :check_admin_moderator_user, only: [:index]
  before_action :find_tax, only: [:show]
  before_action :find_order, only: [:show, :order_detail]

  def index
    @orders = Order.includes(:order_items).where(user_id: current_user.id).paginate(page: params[:page], per_page: 10)
  end

  def show
    @rider = Rider.new
    @riders = User.rider
    @rider = @order.rider.where.not(order_status: "reject").first
  end

  def customer_orders
    @reg_orders = Order.registered_orders.where.not(user_id: current_user.id).order('created_at DESC').paginate(page: params[:reg_page], per_page: 5)
    @guest_orders = Order.guest_orders.order('created_at DESC').paginate(page: params[:guest_page], per_page: 5)
    @from_branch_orders = Order.from_branch_orders.order('created_at DESC').paginate(page: params[:branch_page], per_page: 5)
  end

  def change_status
    order = Order.find(params[:id])
    order.update_attribute(:status, params[:order][:status])
    rider = Rider.new(rider_params)
    rider.order_status = "pending"
    if rider.save
      flash[:success] = "Rider has been Assign to Order"
      redirect_to customer_orders_admin_order_histories_path
    end
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

  def order_detail
    respond_to do |format|
      format.js
    end
  end


  private

  def rider_params
    params.require(:order).require(:rider).permit(:user_id, :order_id, :pickup_time, :delivery_time)
  end

  def find_order
    @order = Order.includes(order_items: [:chef_category_item]).find(params[:id])
  end

  def find_tax
    if Tax.any?
      @tax = Tax.first.tax
      @tax_percentage = @tax.to_f / 100
    else
      @tax = 0
      @tax_percentage = 0
    end
  end
end

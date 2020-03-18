class Admin::OrdersController < Admin::BaseController

  def index

  end

  def new
    @categories = Category.all
    @order = Order.new
    @order.order_items.build
    @country = "Pakistan"
    @user = User.new
    @states = CS.states(:PK)
  end

  def order_items
    @data = MenuItem.where(category_id: params[:category])
    @menu_items = @data.map{ |k| [k.id,k.title] }
    render json: @menu_items
  end

  def order_chefs
    @data = ChefCategoryItem.where(menu_item_id: params[:menu_item])
    @chef_category = @data.map{ |k|[k.id,k.chef_category.user.first_name] }
    render json: @chef_category
  end

  def create
    @exists = User.find_by_phone(params[:order][:phone])
    if @exists.present?
      @order = Order.new(order_params)
      @order.user_id = @exists.id
      @order.ordered_as = "order_from_branch"
      # @order.order_items.new(order_item_params)
      @order.save(validate: false)
    else
      @user = User.new(user_params)
      @order = @user.orders.new(order_params)
      @order.ordered_as = "order_from_branch"
      # @order.order_items.new(order_item_params)
      @user.save(validate: false)
      @order.save(validate: false)
    end
    flash[:success] = "Order Created Successfullly"
    redirect_to customer_orders_admin_order_histories_path
  end

  def checkemail
    @exists = User.find_by_phone(params[:phone]).present?
  end

  def check_cities
    @cities = CS.cities(params[:state], :pk)
    render json: @cities
  end

  def add_form_field
    @categories = Category.all
    respond_to do |format|
      format.js
    end
  end

  private
  def order_params
    params.require(:order).permit(:phone, order_items_attributes: [ :chef_category_item_id, :quantity, :special_request, :total ] )
  end

  def order_item_params
    params.require(:order).require(:order_item).permit(:chef_category_item_id, :quantity, :special_request, :total)
  end

  def user_params
    params.require(:order).require(:user).permit(:first_name, :last_name, :email, :phone, :country, :state, :city, :address)
  end
end
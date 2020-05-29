class Admin::OrdersController < Admin::BaseController
  before_action :find_tax, only: [:new]

  def index

  end

  def new
    @categories = Category.all
    @order = Order.new
    @order.order_items.build
    @order.order_special_items.build
    @country = "Pakistan"
    @user = User.new
    @states = CS.states(:PK)
    @city = CS.cities(:PB,:PK).second
    @special_items = SpecialItem.all
  end

  def order_items
    @data = MenuItem.where(category_id: params[:category])
    @menu_items = @data.map{ |k| [k.id,k.title] if k.chef_category_items.present? }
    render json: @menu_items
  end

  def order_chefs
    @chef_data = ChefCategoryItem.where(menu_item_id: params[:menu_item])
    @data = ChefAvalibility.where(chef_category_item_id: @chef_data.ids).where(day: Time.now.strftime("%A"))
    @chef_category = @data.map{ |k|[k.chef_category_item_id, k.chef_category_item.chef_category.user.first_name] }
    render json: @chef_category
  end

  def create
    new_user_params = params.require(:order).require(:user).permit(:first_name, :email, :phone, :country, :state, :city, :address)
    @exists = User.find_by_phone(params[:order][:phone])
    if @exists.present?
      @order = Order.new(order_params)
      @order.user_id = @exists.id
      @order.ordered_as = "order_from_branch"
      @order.save(validate: false)
    else
      if !params[:order][:user][:email].present?
        new_user_params = new_user_params.merge!({email: "customer_#{(User.last&.id || 0) + 1}@gmail.com", password: "123456"})
      else
        new_user_params = new_user_params.merge!({password: "123456"})
      end
      @user = User.new(new_user_params)
      @user.confirmed_at = Time.now
      @order = @user.orders.new(order_params)
      @order.ordered_as = "order_from_branch"
      @user.save(validate: false)
      @order.save(validate: false)
    end
    flash[:success] = "Order Created Successfullly"
    render :js => "window.location.pathname='#{customer_orders_admin_order_histories_path}'"
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

  def menu_item
    menu_item_price = MenuItem.find(params[:menu_item]).price
    render json: menu_item_price
  end

  private

    def order_params
      params.require(:order).permit(:phone, :sub_total, :city, :state, :address_one, order_items_attributes: [ :chef_category_item_id, :quantity, :special_request, :total ], order_special_items_attributes: [ :special_item_id, :quantity, :price] )
    end

    # def new_user_params
    #   params.require(:order).require(:user).permit(:first_name, :email, :phone, :country, :state, :city, :address)
    # end

    def order_item_params
      params.require(:order).require(:order_item).permit(:chef_category_item_id, :quantity, :special_request, :total)
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
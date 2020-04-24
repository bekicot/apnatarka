class DeliveryController < ApplicationController
  include DeliveryHelper
  include PayTabs
  before_action :find_tax, only: [:checkout, :save_order, :order_received, :index]

  skip_before_action :verify_authenticity_token, only: %i[paytabs_callback]

  def index
    prepare_items
  end

  def checkout
    @states = CS.states(:PK)
    if session[:cart].present?
      @latitude     = request.location.latitude
      @longitude    = request.location.longitude
      gon.latitude  = @latitude
      gon.longitude = @longitude
      gon.loc       = Geocoder.search([@latitude, @longitude])&.first&.address
      prepare_items
    else
      redirect_to delivery_index_path
    end
  end

  def get_cities
    @cities = CS.cities(params[:state], :pk)
    render json: @cities
  end

  def save_order
    if (current_user.present? && current_user.confirmed_at.present?) || session[:guest_order].present?
      @order             = Order.new(delivery_params)
      @order.location_id = Location.find_by(address: params[:order][:location])&.id if params[:order][:location].present?
      @order.build_address(address_params) unless (params[:order][:address_id].present? || session[:delivery_details].present?)
      prepare_items

      @chef_menu_items.each do |chef_menu_item|
        quantity        = session[:cart][ChefCategoryItem.item_key_for_cart(chef_menu_item.id)]
        special_request = session[:special_request][ChefCategoryItem.item_key_for_cart(chef_menu_item.id)]
        @order.order_items.new(chef_category_item_id: chef_menu_item.id, quantity: quantity,
                               total: (quantity * chef_menu_item.menu_item.price), special_request: special_request)
      end

      @order.vat            = @tax_percentage
      sub_total_without_vat = @order.order_items.sum{|x| x.total}
      @order.sub_total      = sub_total_without_vat + (sub_total_without_vat * @order.vat)
      @order.ordered_as     = current_user.present? ? Order.ordered_as[:registered_user] : Order.ordered_as[:guest_user]
      @order.user_id        = current_user.id if current_user.present?
      @order.save!
      # if @order.debit_credit_card?
        # payment_integration(@order)
      # else
      redirect_to order_received_delivery_path(@order.id)
      # end
    else
      redirect_to checkout_delivery_index_path
    end
  end

def order_received
    flash[:success] = "Your Order Has Been Placed Successfully"
    clear_all_sessions
    @order = Order.includes(order_items: [:chef_category_item]).find(params[:id])
  end

  def add_to_cart
    @chef_menu_item = ChefCategoryItem.find(params[:chef_menu_item])
    @total = 0
    if params[:chef_menu_item].present?
      session[:cart]            = {} if session[:cart].blank?
      session[:special_request] = {} if session[:special_request].blank?
      quantity = params[:quantity].present? ? params[:quantity].to_i : 1
      session[:cart].merge!(ChefCategoryItem.item_to_add_in_cart(params[:chef_menu_item], quantity))
      if params[:add_more].present?
        prepare_items
        @add_more = true
        @menu_item = ChefCategoryItem.find params[:menu_item]
        @selected_item_text = t("delivery.added")
      end
    end
    prepare_items
  end

  def special_request
    if params[:chef_menu_item_id].present? && params[:special_request].present?
      session[:special_request] = {} if session[:special_request].blank?
      chef_menu_item_id              = params[:chef_menu_item_id]
      special_request           = params[:special_request]
      session[:special_request].merge!(ChefCategoryItem.special_request_to_add_in_cart(chef_menu_item_id, special_request))
      return render json: {data: :ok}
    end
  end

  def update_quantity
    item = params[:chef_menu_item_id]
    key_to_update = ChefCategoryItem.item_key_for_cart(item)
    session[:cart][key_to_update] = params[:quantity].to_i
    prepare_items
  end

  def remove_item
    key_to_delete = ChefCategoryItem.item_key_for_cart(params[:id])
    session[:cart].delete(key_to_delete)
    session[:special_request].delete(key_to_delete) if session[:special_request]&.has_key?(key_to_delete)
    redirect_to delivery_index_path
  end

  def add_more_items
    @categories = Category.includes(:menu_items)
  end

  def guest_order
    session[:guest_order] = true
    flash[:success] = "You are successfully signed in as guest"
    redirect_to root_path
  end

  def set_delivery_mode
    @delivery_mode = params[:delivery_mode]
    @want_it_for   = params[:want_it_for]
    session.delete(:delivery_time) if @want_it_for == 'delivery_now'
    @franchise_locations = Location.with_translations(I18n.locale)
    respond_to do |format|
      format.js
    end
  end

  def save_delivery_mode
    session[:delivery_details] = {}
    session[:delivery_details].merge!(delivery_mode: params[:delivery_mode], location_id: params[:location_id])
    session[:delivery_details].merge!(pick_time: params[:pick_time]) if params[:pick_time].present?
    render nothing: true
  end

  def new_or_current_address
    @address = params[:address_type]
    respond_to do |format|
      format.js
    end
  end

  def add_to_favorite
    @order = Order.find(params[:id])
    @order.update_attribute(:is_favorite, true)
    redirect_to order_received_delivery_path(@order.id)
  end

  def all_favorite_orders
    if user_signed_in?
      @orders = current_user.orders.where(is_favorite: true)
    else
      flash[:alert] = t("crud.access_denied")
      redirect_back(fallback_location: root_path)
    end
  end

  def show_favorite_order
    @order = Order.includes(order_items: [:menu_item]).find(params[:id])
  end

  def paytabs_callback
    order = Order.find(params[:order])
    if params[:payment_reference].present?
      order.update_attributes(payment_reference: params[:payment_reference], status: Order.statuses[:paid])
    else
      order.update_attribute(status: Order.statuses[:unpaid])
    end
    redirect_to order_received_delivery_path(order.id)
  end

  def re_payment
    order = Order.find(params[:order])
    payment_integration(order)
  end

  def chef_items
    @menu_item = MenuItem.find(params[:menu_id])
    @chef_category_items = @menu_item.chef_category_items
    @categories = Category.all
    respond_to do |format|
      format.js
    end
  end

  private

  def delivery_params
    params.require(:order).permit(:first_name, :last_name, :email, :phone, :address_two, :city,
                                  :state, :post_code, :payment_method, :terms, :long, :lat,
                                  :is_location_check, :delivery_time, :address_id, :address_one)
  end

  def address_params
    params.require(:order).require(:address).permit(:user_id, :address_type, :building_name,
                                                    :building_number, :room_no, :direction)
  end

  def prepare_items
    if session[:cart].present?
      chef_menu_item_ids = session[:cart].keys.map {|key| ChefCategoryItem.get_item_from_cart(key) }
      @chef_menu_items = ChefCategoryItem.where(id: chef_menu_item_ids)
    else
      redirect_to root_path(anchor: 'complete_menu')
    end
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

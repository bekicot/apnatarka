class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:show, :destroy, :edit, :update, :order_history, :pay_amount, :chef_history, :record_by_date, :chef_inventory_by_date ]
  before_action :check_super_admin, only: [:destroy, :edit, :update]
  #before_action :check_moderator_user, only: [:destroy]
  before_action :check_admin_moderator_user, only: [:index]
  skip_before_action :verify_authenticity_token, only: [:create, :update]
  before_action :find_country_and_state, only: [:new, :edit, :create, :update]

  def index
    @users = User.all.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    @user.confirmed_at = Time.now
    if @user.save
      # UserMailer.delay.account_creation_email(user)
      flash[:success] =  t("crud.user_created")
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def get_cities
    @cities = CS.cities(params[:state], :pk)
    render json: @cities
  end

  def edit
  end

  def update
    if @user.update(sign_up_params)
      flash[:success] = t("crud.user_update")
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @user.destroy
    flash[:success] = t("crud.user_delete")
    redirect_back(fallback_location: root_path)
  end

  def user_roles
    @users = User.where(role: params[:user_role]).order('created_at DESC').paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.js
    end
  end

  def order_history
    @total_amount = 0
    @rider_history = @user.riders.where('created_at::date = ?', Date.today).order('created_at DESC').paginate(page: params[:rider_page], per_page: 10)
    @amount = RiderAmount.where(user_id: @user.id).map{|x| x.total }
    @amount.each { |total| @total_amount += total }
  end

  def record_by_date
    @rider_history = @user.riders.where("created_at::date = ?", params[:date]).order('created_at DESC').paginate(page: params[:rider_page], per_page: 10)
  end

  def pay_amount
    order_status = @user.riders.where(order_status: "deliver")
    rider_status = @user.riders.where(payment_status: "cash_on_delivery")
    ids = order_status.map{|x| x.order_id }
    orders = Order.where(id: ids)
    orders.update_all(status: "paid")
    rider_status.update_all(payment_status: "receive")
    rider_status
    @user.rider_amounts.destroy_all
    redirect_to order_history_admin_user_path(@user)
  end

  def chef_history
    @assign_items = AssignItem.where(chef_id: @user.id).order('created_at DESC').paginate(page: params[:chef_page], per_page: 5)
  end

  def chef_inventory_by_date
    @assign_items = AssignItem.where(chef_id: @user.id).where("assign_date::date = ?", params[:date]).order('created_at DESC').paginate(page: params[:chef_page], per_page: 5)
  end

  private

  def find_user
    @user = User.friendly.find(params[:id])
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :phone, :email, :password, :password_confirmation, :role, :country, :state, :city, :address, :avatar)
  end

  def check_super_admin
    if @user.super_admin?
      flash[:alert] = t("crud.access_denied")
      redirect_back(fallback_location: root_path)
    end
  end

  def find_country_and_state
    @country = "Pakistan"
    @states = CS.states(:PK)
  end
end

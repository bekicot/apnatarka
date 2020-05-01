class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:show, :destroy, :edit, :update]
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

  private

  def find_user
    @user = User.find_by_id(params[:id])
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

class Admin::UsersController < Admin::BaseController
  before_action :find_user, only: [:show, :destroy, :edit, :update]
  before_action :check_super_admin, only: [:destroy, :edit, :update]
  #before_action :check_moderator_user, only: [:destroy]
  before_action :check_admin_moderator_user, only: [:index]

  skip_before_action :verify_authenticity_token, only: [:create]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @states = CS.states(:PK)
  end

  def create
    debugger
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

  private

  def find_user
    @user = User.find_by_id(params[:id])
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role, :country, :state, :city, :image)
  end

  def check_super_admin
    if User.user_roles[:super_admin].eql? @user.role
      flash[:alert] = t("crud.access_denied")
      redirect_back(fallback_location: root_path)
    end
  end
end

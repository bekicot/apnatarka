class Admin::LocationsController < Admin::BaseController
  before_action :find_location, only: [:show, :destroy, :edit, :update]
  before_action :check_admin_moderator_user, only: [:destroy, :index]

  def index
    @locations = Location.with_translations(session_language)
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      flash[:success] = t("crud.location_created")
    else
      render :new
    end
    redirect_to admin_locations_path
  end

  def edit
  end

  def update
    if @location.update(location_params)
      flash[:success] = t("crud.location_update")
    else
      render :edit
    end
    redirect_to admin_locations_path
  end

  def show
  end

  def destroy
    if @location.destroy
      flash[:success] = t("crud.location_delete")
    else
      flash[:notice] = t("crud.error_location_delete")
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def find_location
    @location = Location.find_by_id(params[:id])
  end

  def location_params
    # permitted = Location.globalize_attribute_names + [:state, :city, :phone, :postal_code, :lat, :lng]
    # params.require(:location).permit(*permitted)
    params.require(:location).permit(:title_en, :address_en, :country_en, :phone, :postal_code, :lat, :lng)
  end
end

class Admin::AboutsController < Admin::BaseController
  before_action :find_about_us, only: [:show, :destroy, :edit, :update]
  before_action :check_admin_moderator_user, only: [:destroy]

  def index
    @abouts = About.with_translations(session_language)
  end

  def new
    @about = About.new
  end

  def create
    @about = About.new(abouts_params)
    if @about.save
      flash[:success] = t("crud.about_created")
      redirect_to admin_abouts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if params[:value].present?
      About.active.with_translations(session_language).update_all(is_active: false)
      @about.update_attribute(:is_active, true)
      @abouts = About.with_translations(session_language)
    elsif @about.update(abouts_params)
      flash[:success] = t("crud.about_update")
      redirect_to admin_abouts_path
    else
      render :edit
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  def show
  end

  def destroy
    if @about.destroy
      flash[:success] = t("crud.about_delete")
    else
      flash[:notice] = t("crud.error_about_delete")
    end
    redirect_to admin_abouts_path
  end

  private

  def find_about_us
    @about = About.find_by_id(params[:id])
  end

  def abouts_params
    permitted = About.globalize_attribute_names
    params.require(:about).permit(*permitted)
  end
end

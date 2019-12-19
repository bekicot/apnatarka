class Admin::CategoriesController < Admin::BaseController
  before_action :find_category, only: [:show, :destroy, :edit, :update]
  # before_action :check_moderator_user, only: [:destroy]
  before_action :check_admin_moderator_user, only: [:index]

  def index
    @categories = Category.with_translations(session_language)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = t("crud.category_created")
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = t("crud.category_update")
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if @category.destroy
      flash[:success] = t("crud.category_delete")
    else
      flash[:notice] = t("crud.error_category_delete")
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def find_category
    @category = Category.find_by_id(params[:id])
  end

  def category_params
    permitted = Category.globalize_attribute_names + [:avatar]
    params.require(:category).permit(*permitted)
  end
end

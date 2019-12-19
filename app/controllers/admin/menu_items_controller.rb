class Admin::MenuItemsController < Admin::BaseController
  before_action :find_menu_item, only: [:show, :destroy, :edit, :update]
  before_action :check_admin_moderator_user, only: [:destroy]

  def index
    @menu_items = MenuItem.with_translations(session_language)
  end

  def new
    @categories = Category.with_translations(session_language)
    @menu_item = MenuItem.new
  end

  def create
    @menu_item = MenuItem.new(menu_item_params)
    if @menu_item.save
      flash[:success] = t("crud.menu_item_created")
      redirect_to admin_menu_items_path
    else
      @categories = Category.with_translations(session_language)
      render :new
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @menu_item.update(menu_item_params)
      flash[:success] = t("crud.menu_item_update")
      redirect_to admin_menu_items_path
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if @menu_item.destroy
      flash[:success] = t("crud.menu_item_delete")
    else
      flash[:success] = t("crud.error_menu_item_delete")
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def find_menu_item
    @menu_item = MenuItem.find_by_id(params[:id])
  end

  def menu_item_params
    permitted = MenuItem.globalize_attribute_names + [:category_id, :avatar, :price]
    params.require(:menu_item).permit(*permitted)
  end
end

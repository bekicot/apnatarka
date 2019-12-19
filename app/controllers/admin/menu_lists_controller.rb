class Admin::MenuListsController < Admin::BaseController
  before_action :check_admin_moderator_user, only: [:destroy]
  before_action :find_menu_list, only: [:edit, :update]

  def index
    @menus = MenuList.all
  end

  def new
    @menu = MenuList.new
  end

  def create
    @menu = MenuList.new(menu_params)
    if @menu.save
      flash[:success] = t("crud.create_menu_list")
      redirect_to admin_menu_lists_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @menu.update(menu_params)
      flash[:success] = t("crud.create_menu_list")
      redirect_to admin_menu_lists_path
    else
      render :edit
    end
  end

  private

  def menu_params
    params.require(:menu_list).permit(:menu_file)
  end

  def find_menu_list
    @menu = MenuList.find_by_id(params[:id])
  end

end

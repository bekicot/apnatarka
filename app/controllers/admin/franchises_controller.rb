class Admin::FranchisesController < Admin::BaseController
  before_action :find_franchise, only: [:show, :destroy]
  before_action :check_admin_moderator_user, only: [:destroy]

  def index
    @franchises = Franchise.all
  end

  def show
  end

  def destroy
    @franchise.destroy
    flash[:success] = "Franchise Deleted Successfullly"
    redirect_back(fallback_location: root_path)
  end

  private

  def find_franchise
    @franchise = Franchise.find_by_id(params[:id])
  end
end

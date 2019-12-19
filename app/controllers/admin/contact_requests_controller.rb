class Admin::ContactRequestsController < Admin::BaseController
  before_action :find_contact_request, only: [:show, :destroy]
  before_action :check_admin_moderator_user, only: [:destroy]

  def index
    @contact_requests = ContactRequest.all
  end

  def show
  end

  def destroy
    @contact_request.destroy
    flash[:success] = "Contact Request Deleted Successfullly"
    redirect_back(fallback_location: root_path)
  end

  private

  def find_contact_request
    @contact_request = ContactRequest.find_by_id(params[:id])
  end
end

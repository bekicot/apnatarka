class Admin::DashboardsController < Admin::BaseController
  before_action :check_admin_moderator_user, only: [:index]

  def index
  	@users = User.all
  	@categories = Category.with_translations(session_language)
  	@menu_items = MenuItem.with_translations(session_language)
  	@contact_requests = ContactRequest.all
  	@feedbacks = Feedback.all
  	@abouts = About.with_translations(session_language)
  	@locations = Location.with_translations(session_language)
  end
end

class Admin::FeedbacksController < Admin::BaseController
  before_action :find_feedback, only: [:show, :destroy]
  before_action :check_admin_moderator_user, only: [:index, :destroy]

  def index
    @feedbacks = Feedback.all
  end

  def show
  end

  def destroy
    @feedback.destroy
    flash[:success] = "Feedback Deleted Successfully"
    redirect_back(fallback_location: root_path)
  end

  private

  def find_feedback
    @feedback = Feedback.find_by_id(params[:id])
  end

end

class VisitorsController < ApplicationController
  skip_before_action :set_locale, only: %i(change_locale)
  before_action :set_emails, only: [:submit_feedback, :submit_franchise, :contact_request]

  def home
    @about                = About.with_translations(session_language).where(is_active: true).first
    @locations            = Location.with_translations(session_language).pluck(:id, :address, :title)
    @menu                 = MenuList.first
    gon.locations         = @locations
    @contact_request      = ContactRequest.new
    @session_language     = session_language
    @categories           = Category.includes(:menu_items).with_translations(@session_language)
  end

  def coming_soon
    render layout: 'coming_soon'
  end

  def login_page
    respond_to do |format|
      format.js
    end
  end

  def logout_guest
    session[:guest_order] = {}
    redirect_to root_path
  end

  def about_us
    redirect_to root_path(anchor: "about_us")
    @about = About.with_translations(session_language).where(is_active: true).first
  end

  def message_us
    redirect_to root_path(anchor: "message_us")
    @contact_request = ContactRequest.new
  end

  def feedback
    @feedback = Feedback.new
  end

  def submit_feedback
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      UserMailer.feedback_email(@emails, @feedback).deliver_later
    end
    redirect_back(fallback_location: feedback_visitors_path)
  end

  def franchise
    @franchise = Franchise.new
  end

  def submit_franchise
    @franchise = Franchise.new(franchise_params)
    if @franchise.save
      UserMailer.franchise_email(@emails, @franchise).deliver_later
    end
    redirect_back(fallback_location: franchise_visitors_path)
  end

  def contact_request
    @contact_request = ContactRequest.new(contact_request_params)
    if verify_recaptcha(model: @contact_request) && @contact_request.save
      UserMailer.contact_request_email(@emails, @contact_request).deliver_later
    end
    redirect_back(fallback_location: root_path)
  end

  def change_locale
    session[:locale] = params[:locale]
    respond_to do |format|
      format.js { render js: "window.location = '#{request.referrer}'" }
    end
  end

  def error_404
  end

  def error_500
  end

  def checkemail
    @exists = User.find_by_email(params[:email]).present?
  end

  private

  def contact_request_params
    params.require(:contact_request).permit(:name, :email, :phone, :message)
  end

  def franchise_params
    params.require(:franchise).permit(:first_name, :last_name, :email, :phone_number, :city, :country)
  end

  def feedback_params
    params.require(:feedback).permit(:name, :email, :mobile_number, :gender, :profession, :hear_through, :hear_through_other, :preference, :experience, :contact_through, :comments)
  end

  def set_emails
    @emails = "azan.abrar@gmail.com, abubakar.shabbir@eritheialabs.com"
  end
end

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  before_action :set_locale, :check_user_present
  layout 'home'

  # before_action :set_coming_soon

  def set_coming_soon
    redirect_to coming_soon_visitors_path unless (params[:controller] == 'visitors' && params[:action] == 'coming_soon')
  end

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def session_language
    session[:locale] || I18n.default_locale
  end

  def check_user_present
    gon.user_exist = (current_user.present? || session[:guest_order].present?)
  end


  protected

  def configure_permitted_parameters
    added_attrs = [:phone, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

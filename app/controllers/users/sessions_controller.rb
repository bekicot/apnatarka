# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout :determine_layouts
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    if !session[:return_to].blank?
     redirect_to session[:return_to]
     session[:return_to] = nil
    else
     respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end

  # DELETE /resource/sign_out
  def destroy
    session_cart = session[:cart]
    super
    flash.clear
    session[:cart] = session_cart
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    if resource.super_admin?
      admin_dashboards_path
    elsif resource.normal_user?
      session[:cart].present? ? checkout_delivery_index_path : root_path
    elsif resource.rider?
      rider_dashboards_path
    elsif resource.chef?
      chef_root_path
    end
  end

  def auth_options
    { scope: resource_name, recall: "visitors#home" }
  end

  def determine_layouts
    'admin'
  end

end

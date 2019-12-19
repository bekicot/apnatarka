class Customer::BaseController < ApplicationController
  before_action :authenticate_user!
  layout :determine_layout
  before_action :check_normal_user

  def determine_layout
    "customer"
  end

  def check_normal_user
    if !current_user.normal_user?
      flash[:alert] = t("crud.access_denied")
      redirect_back(fallback_location: root_path)
    end
  end
end

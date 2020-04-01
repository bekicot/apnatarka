class Rider::BaseController < ApplicationController
  before_action :authenticate_user!
  layout :determine_layout
  before_action :check_rider_user

  def check_rider_user
    if !current_user.rider?
      flash[:alert] = t("crud.access_denied")
      redirect_back(fallback_location: root_path)
    end
  end

  def determine_layout
    "rider"
  end
end
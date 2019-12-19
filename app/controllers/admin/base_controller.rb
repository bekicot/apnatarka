class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  layout :determine_layout
  before_action :check_admin_moderator_user

  def determine_layout
    "admin"
  end

  def check_admin_moderator_user
    if !current_user.moderator_user? && !current_user.super_admin?
      # flash[:alert] = t("crud.access_denied")
      redirect_back(fallback_location: root_path)
    end
  end
end

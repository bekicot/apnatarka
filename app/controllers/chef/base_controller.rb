class Chef::BaseController < ApplicationController
	before_action :authenticate_user!
  	layout :determine_layout
  	before_action :check_chef_user

  	def check_chef_user
    if !current_user.chef?
      flash[:alert] = t("crud.access_denied")
      redirect_back(fallback_location: root_path)
    end
  end

  def determine_layout
    "chef"
  end
end

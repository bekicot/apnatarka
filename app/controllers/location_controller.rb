class LocationController < ApplicationController

  def index
    redirect_to root_path(anchor: "location")
  end

  def show
    location  = Location.with_translations(session_language).find(params[:id])
    @map_data = location.to_json(only: %i(address lat lng))
  end
end

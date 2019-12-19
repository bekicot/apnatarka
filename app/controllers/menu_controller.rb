class MenuController < ApplicationController

  def index
    redirect_to root_path(anchor: "menu_section")
    @categories = Category.with_translations(session_language)
    @session_language = session_language
    respond_to do |format|
      format.js
      format.html
    end
  end

  def single_item
    @menu_item = MenuItem.with_translations(session_language).find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end
end

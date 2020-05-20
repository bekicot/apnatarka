class ChefMenusController < ApplicationController
  before_action :find_chef, only: [:chef_mess_items]
  before_action :find_mess, only: [:mess_request, :mess_customise]
  before_action :find_chef_detail, only: [:mess_request]

  def index
    @chefs = User.chef.paginate(page: params[:page], per_page: 12)
  end

  def chef_mess_items
    @mess_items = @chef.mess_items
    @mess = @chef.mess
  end

  def mess_request
    if current_user.present?
      if !current_user.mess_request.present?
        mess_request = MessRequest.create(mess_id: params[:id], user_id: current_user.id, status: "pending", chef_id: params[:user_id])
        mess_item = @chef_mess.mess_items
        user_mess = []
        mess_item.each do |item|
          user_mess << UserMess.new(mess_item_id: item.id, mess_request_id: mess_request.id)
        end
        UserMess.import user_mess
      end
    end
  end

  def mess_customise
    if current_user.present?
      if !current_user.mess_request.present?
        @chef = @chef_mess.user
        @mess_items = @chef_mess.mess_items
        @user_mess = []
        @mess_items.each do |item|
          @user_mess << UserMess.new(mess_item_id: item.id)
        end
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def save_customise_mess
    user_mess = []
    ids = params[:ids]
    mess_items = MessItem.where(id: ids)
    mess_id = mess_items.first.mess_id
    chef = MessItem.where(id: ids).first.mess.user
    mess_request = MessRequest.create(mess_id: mess_id, chef_id: chef.id, user_id: current_user.id, status: "pending")
    mess_items.each do |item|
      user_mess << UserMess.new(mess_item_id: item.id, mess_request_id: mess_request.id)
    end
    UserMess.import user_mess
    # values that are required for render page
    @mess_items = chef.mess_items
    @mess = chef.mess
  end

  private
  def find_chef
    @chef = User.find(params[:id])
  end

  def find_mess
    @chef_mess = Mess.find(params[:id])
  end

  def find_chef_detail
    @chef = User.find(params[:user_id])
    @mess_items = @chef.mess_items
    @mess = @chef.mess
  end
end

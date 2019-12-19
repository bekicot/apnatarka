class AddressController < ApplicationController

  def set_delivery_address
    session[:address] = {}
    if params[:address].try(:[], :new_address).present?
      session[:address].merge!(address: params[:address])
    else
      address = current_user.addresses.find(params[:address][:direction])
      session[:address].merge!(address_type: address.address_type, building_name: address.building_name, building_number: address.building_number, room_no: address.room_no, direction: address.direction, address_id: address.id)
    end
    respond_to do |format|
      format.js
    end
  end

  def set_delivery_time
    session[:delivery_time] = {}
    session[:delivery_time].merge!(delivery_time: params[:delivery_time])
    respond_to do |format|
      format.js
    end
  end

end

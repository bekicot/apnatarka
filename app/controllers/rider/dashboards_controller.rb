class Rider::DashboardsController < Rider::BaseController
	
	def index
		@orders = current_user.riders.includes(:order)
	end

	def deliver_order
		rider = Rider.find(params[:id])
		rider.update_attribute(:reached_time, Time.now)
		flash[:success] = "Order has be Deliverd Sucessfully"
		redirect_to rider_dashboards_path
	end

	def show
		@rider = Rider.includes(:order).find(params[:id])
	end
end

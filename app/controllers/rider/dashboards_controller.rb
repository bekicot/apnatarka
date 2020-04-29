class Rider::DashboardsController < Rider::BaseController
	before_action :find_tax, only: [:show]
	def index
		@orders = current_user.riders.includes(:order).order('created_at DESC').paginate(page: params[:page], per_page: 10)
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

	private
		def find_tax
		    if Tax.any?
		      @tax = Tax.first.tax
		      @tax_percentage = @tax.to_f / 100
		    else
		      @tax = 0
		      @tax_percentage = 0
		    end
		  end
end

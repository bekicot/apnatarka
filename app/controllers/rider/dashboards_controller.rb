class Rider::DashboardsController < Rider::BaseController
	before_action :find_tax, only: [:show]
	before_action :find_rider, only: [:accept_order, :reject_order, :save_reason]
	before_action :find_order, only: [:index, :deliver_order, :accept_order, :reject_order]
	def index
		
	end

	def deliver_order
		@rider = Rider.find(params[:id])
		if @rider.order.status == "cash_on_delivery"
			RiderAmount.create(user_id: current_user.id, total: @rider.order.sub_total)
		end
		if @rider.delivery_time.strftime("%I:%M %p") >= Time.now.strftime("%I:%M %p")
			@rider.update_attributes(reached_time: Time.now, order_status: "deliver", delivery_status: "on_time" )
			# flash[:success] = "Order has be Deliverd Sucessfully"
			# redirect_to rider_dashboards_path
		else
			@rider.update_attributes(reached_time: Time.now, order_status: "deliver", delivery_status: "late" )
		end
		respond_to do |formate|
			formate.js
		end
	end

	def save_reason
		@rider.update_attribute(:reason, params[:rider][:reason])
		redirect_to rider_dashboards_path
		flash[:success] = "Thanks for Your Feeback"
	end

	def show
		@rider = Rider.includes(:order, :user).find(params[:id])
	end

	def accept_order
		@rider.update_attribute(:order_status, "accept")
		respond_to do |formate|
			formate.js
		end
	end

	def reject_order
		@rider.update_attribute(:order_status, "reject")
		respond_to do |formate|
			formate.js
		end
	end

	def rider_history
		@rider_history = current_user.riders.includes(:order).order('created_at DESC').paginate(page: params[:rider_page], per_page: 10)
	end

	def record_by_date
		@riders_order = current_user.riders.where.not(order_status: "reject")
		@orders = @riders_order.where("created_at::date = ?", params[:date]).includes(:order).order('created_at DESC').paginate(page: params[:page], per_page: 10)
	  @total_amount = 0
		@amount = RiderAmount.where(user_id: current_user.id).map{|x| x.total }
		@amount.each { |total| @total_amount += total }
	end

	def history_by_date
		@rider_history = current_user.riders.where("created_at::date = ?", params[:date]).includes(:order).order('created_at DESC').paginate(page: params[:rider_page], per_page: 10)
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

	  def find_rider
	  	@rider = Rider.find(params[:id])
	  end

	  def find_order
			@orders = current_user.riders.where.not(order_status: "reject").where("created_at::date = ?", Date.today).includes(:order)
			.order('created_at DESC').paginate(page: params[:page], per_page: 10)
	  	@total_amount = 0
			@amount = RiderAmount.where(user_id: current_user.id).map{|x| x.total }
			@amount.each { |total| @total_amount += total }
	  end
end

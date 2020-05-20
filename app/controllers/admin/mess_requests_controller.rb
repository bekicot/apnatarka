class Admin::MessRequestsController < Admin::BaseController

	def index
		@mess_requests = MessRequest.all.includes(:mess, :user).order('created_at DESC').paginate(page: params[:page], per_page: 10)
	end

	def show
		@mess_request = MessRequest.find(params[:id])
		@user_mess = @mess_request.user_messes.includes(mess_item: [chef_category_item: [:menu_item] ]).order('created_at DESC').paginate(page: params[:show_page], per_page: 10)
	end
end
class Chef::MessesController < Chef::BaseController
	before_action :find_user, only: [:index, :create]
	before_action :find_chef_details, only: [:new, :create]
	before_action :find_mess, only: [:destroy, :edit, :update]

	def index
		@mess = @user.mess
	end

	def new
		@mess = Mess.new
		@mess.mess_items.build
	end

	def create
		@mess = Mess.new(mess_params)
		@mess.user_id = @user.id
		if @mess.save
			flash[:success] = "Mess Created Successfullly"
			redirect_to chef_messes_path
		else
			flash[:success] = "Something Wrong try again"
			render :new
		end
	end

	def edit
		respond_to do |format|
      format.js
    end
	end

	def update
		if @mess.update(title: params[:mess][:title])
			flash[:success] = "Mess Updated Successfullly"
			redirect_to chef_messes_path
		else
			flash[:success] = "Something Wrong try again"
			render :edit
		end
	end

	def destroy
		if @mess.destroy
			flash[:success] = "Mess Deleted Successfullly"
			redirect_to chef_messes_path
		end
	end

	private
		def find_user
			@user = current_user
		end

		def mess_params
			params.require(:mess).permit(:title, mess_items_attributes: [:chef_category_item_id, :day, :avalible_in])
		end

		def find_chef_details
			@chef_categories = current_user.chef_category_items
    	@days = MessItem.days
    	@avalible_in = MessItem.avalible_ins
		end

		def find_mess
			@mess = current_user.mess.find(params[:id])
		end
end
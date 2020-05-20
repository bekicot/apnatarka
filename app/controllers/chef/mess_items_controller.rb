class Chef::MessItemsController < Chef::BaseController
	before_action :find_mess, only: [:index, :new, :edit]
	before_action :find_mess_item, only: [:edit, :update, :destroy]
	before_action :days_avaliblty_chef_categories, only: [:new, :edit, :update, :create]
	
	def index
		@mess_items = @mess.mess_items.order('created_at DESC').paginate(page: params[:page], per_page: 10)
	end

	def new
		@mess_item = MessItem.new
		respond_to do |format|
      format.js
    end
	end

	def create
		@mess_item = MessItem.new(mess_item_params)
		if @mess_item.save
			flash[:success] = "Item Created Sucessfully"
			redirect_to chef_mess_items_path(mess_id: @mess_item.mess_id)
		else
			flash[:alert] = "Have Some Problem Try Again"
			render :new
		end
	end

	def edit
		respond_to do |format|
      format.js
    end
	end

	def update
		if @mess_item.update(mess_item_params)
			flash[:success] = "Item Updated Sucessfully"
			redirect_to chef_mess_items_path(mess_id: @mess_item.mess_id)
		else
			flash[:alert] = "Have Some Problem Try Again"
			render :edit
		end
	end

	def destroy
		@mess = @mess_item.mess_id
    if @mess_item.destroy
      flash[:success] = "Mess Item Deleted Successfullly"
    end
    redirect_to chef_mess_items_path(mess_id: @mess)
	end

	private

		def mess_item_params
			params.require(:mess_item).permit(:chef_category_item_id, :day, :avalible_in, :mess_id, :price)
		end
		def find_mess
			@mess = current_user.mess.where(id: params[:mess_id]).first
		end

		def find_mess_item
			@mess_item = MessItem.find(params[:id])
		end

		def days_avaliblty_chef_categories
    	@chef_categories = current_user.chef_category_items
    	@days = MessItem.days
    	@avalible_in = MessItem.avalible_ins
  	end
end
class Admin::ChefMessController < Admin::BaseController
  before_action :find_user, only: [:index, :new, :create, :edit, :update]
  before_action :find_mess, only: [:destroy, :edit, :update]
  def index
    @mess = @user.mess
  end

  def new
    @mess = Mess.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @mess = Mess.new(mess_params)
    @mess.user_id = @user.id
    if @mess.save
      flash[:success] = "You Have Added Mess Successfullly"
      redirect_to admin_chef_mess_index_path(user_id: @user.id)
    else
      flash[:alert] = "Something Went Wrong Try Again"
      render :back
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @mess.update(mess_params)
      flash[:success] = "You Have Updated Mess Successfullly"
      redirect_to admin_chef_mess_index_path(user_id: @user.id)
    else
      flash[:alert] = "Something Went Wrong Try Again"
      render :back
    end
  end

  def destroy
    if @mess.destroy
      flash[:success] = "You Have Deleted Mess Successfullly"
    end
    redirect_to admin_chef_mess_index_path(user_id: params[:user_id] )
  end


  private
  def find_user
    @user = User.friendly.find(params[:user_id])
  end

  def mess_params
    params.require(:mess).permit(:title)
  end
  def find_mess
    @mess =  Mess.find(params[:id])
  end
end

class Admin::MeasuresController < Admin::BaseController
	before_action :find_measure, only: [:edit, :update, :destroy]
	def index
		@measures = Measure.all
	end

	def new
		@measure = Measure.new
		respond_to do |format|
      format.js
    end
	end

	def create
    @measure = Measure.new(title: params[:measure][:title].downcase)
    if @measure.save
      flash[:success] = "You Have Add Measure Sucessfully"
    	redirect_to admin_measures_path
    else
    	render 'new'
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @measure.update(title: params[:measure][:title].downcase)
      flash[:success] = "You Have Updated Measure Sucessfully"
      redirect_to admin_measures_path
    else
      render 'edit'
    end
  end

  def destroy
    if @measure.destroy
      flash[:success] = "You Have Deleted Measure Sucessfully"
      redirect_to admin_measures_path
    end
  end

  private
  	
  	def measure_params
  		params.require(:measure).permit(:title).downcase
  	end

  	def find_measure
  		@measure = Measure.find(params[:id])
  	end
end

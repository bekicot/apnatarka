class Admin::TaxesController < Admin::BaseController
  before_action :find_tax, only: [:edit, :update, :destroy]

  def index
    @taxes = Tax.all
  end

  def new
    @tax = Tax.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @tax = Tax.new(tax_params)
    if @tax.save
      flash[:success] = "You Have Add Tax Sucessfully"
      redirect_to admin_taxes_path
    else
      render :back
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @tax.update(tax_params)
      flash[:success] = "You Have Updated Tax Sucessfully"
      redirect_to admin_taxes_path
    else
      render :back
    end
  end

  def destroy
    if @tax.destroy
      flash[:success] = "You Have Deleted Tax Sucessfully"
      redirect_to admin_taxes_path
    end
  end

  private
  def find_tax
    @tax = Tax.find(params[:id])
  end
  def tax_params
    params.require(:tax).permit(:tax)
  end
end

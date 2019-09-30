class OffersalexrController < ApplicationController
  def index
   @offer = Offer.all
 end

  def show
    @offer = Offer.find(params[:id])
  end

  def new
    @offer = Offer.new
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def create
    @offer = Offer.new(offeralexr_params)

    if @offer.save
      redirect_to @offer
    else
      render 'new'
    end
  end

  def update
    @offer = Offer.find(params[:id])

    if @offer.update(offeralexr_params)
      redirect_to @offer
    else
      render 'edit'
    end
  end

  def destroy
    @offer = Offer.find(params[:id])
    @offer.destroy

    redirect_to offersalexr_path
  end

  private
    def offeralexr_params
      params.require(:offer).permit(:title, :text)
    end
end

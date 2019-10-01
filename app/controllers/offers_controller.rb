class OffersController < ApplicationController
  def home
    @offers = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def apply
    offerId = params[:id]
    offer = Offer.find(offerId)
    applicantId = GlobalData.find(1).user_id
    applicant = User.find(applicantId)
    Application.create offer_id: offerId, user_id: applicantId
    redirect_to "/offers/#{offerId}"
  end
end

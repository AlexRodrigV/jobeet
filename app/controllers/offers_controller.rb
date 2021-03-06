class OffersController < ApplicationController
  before_action :authorize_applicant

  def home
    @offers = Offer.all
    @user = User.where(email: GlobalData.find(1).Email).first
    @percentages = Array.new
    if @user.isPremium
      @offers.each do |offer|
        @percentages.push(getPercentage(offer.id, @user.id))
      end
    end
  end

  def show
    @offer = Offer.find(params[:id])
    @user = User.where(email: GlobalData.find(1).Email).first
    userId = @user.id
    @haveApplied = Application.where(user_id: userId, offer_id: @offer.id).exists?
    @percentage = getPercentage(params[:id], userId)
  end

  def apply
    offerId = params[:id]
    applicantId = User.where(email: GlobalData.find(1).Email).first.id
    tmp = User.where(email: GlobalData.find(1).Email).first.email.clone.gsub!(/[@.-_]/, '@' => "at", '.' => '', '-' => '', '_' => '').downcase
    Application.create offer_id: offerId, user_id: applicantId, percentage: getPercentage(offerId, applicantId), idchatuser: tmp, idchatoffer: Offer.find(params[:id]).identifier, isAccepted: false
    redirect_to "/offers/"
  end

  

  def unsuscribe
    offerId = params[:id]
    applicantId = User.where(email: GlobalData.find(1).Email).first.id
    Application.where(user_id: applicantId, offer_id: offerId).first.destroy
    redirect_to "/offers"
  end
end

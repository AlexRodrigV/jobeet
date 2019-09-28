class EnterpriseController < ApplicationController
  def home
  end

  def index
    @enterprise = Enterprise.find(1)
  end

  def create
    @test = params[:title]
    @recruiterId = GlobalData.find(1).recruiter_id
    @offer = Offer.create title:params[:title], recruiter_id: @recruiterId
    redirect_to "/enterprise"
  end

  def show
    @offer = Offer.find(params[:id])
  end

end

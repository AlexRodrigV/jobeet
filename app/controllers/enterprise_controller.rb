class EnterpriseController < ApplicationController
  def home
  end

  def index
    @enterprise = Enterprise.find(1)
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def create
    o = Offer.create title: params[:title], description: params[:description], recruiter_id:GlobalData.find(1).user_id
    skills = params[:skills]
    skills.each do |skill|
      SkillOffer.create offer_id:o.id, skill_id:Skill.where(name:skill).first.id
    end
    redirect_to '/enterprise'
  end

  def update
    @offer = Offer.find(params[:id])
    @offer.update title: params[:title]
    @offer.update description: params[:description]
    @offer.update keywords: params[:keywords]
    redirect_to "/enterprise/#{params[:id]}"
  end

end

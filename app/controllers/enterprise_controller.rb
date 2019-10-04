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
    if (skills.length != 0)
      skills.each do |skill|
        SkillOffer.create offer_id:o.id, skill_id:Skill.where(name:skill).first.id
      end
    end
    redirect_to '/enterprise'
  end

  def delete
    Offer.find(params[:id]).destroy
    redirect_to '/enterprise'
  end

  def change
    @offer = Offer.find(params[:id])
  end

  def update
    o = Offer.all.first
    o.update title: params[:title], description: params[:description]
    redirect_to "/enterprise"
  end
  
end

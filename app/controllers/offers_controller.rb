class OffersController < ApplicationController
  def home
    @offers = Offer.all
  end

  def show
    @offer = Offer.find(params[:id])
    userId = User.where(email: GlobalData.find(1).Email).first.id
    @haveApplied = Application.where(user_id: userId, offer_id: @offer.id).exists?
  end

  def apply
    offerId = params[:id]
    offer = Offer.find(offerId)

    applicantId = User.where(email: GlobalData.find(1).Email).first.id
    applicant = User.find(applicantId)

    applicantSkills = SkillUser.where(user_id: applicantId)
    offerSkills = SkillOffer.where(offer_id: offerId)

    common = 0
    offerSkills.each do |skillOffer|
      offerSkill = Skill.find(skillOffer.skill_id)
      applicantSkills.each do |applicantSkill|
        applicantSkill = Skill.find(applicantSkill.skill_id)
        if (offerSkill.name == applicantSkill.name)
          common += 1
        end
      end
    end

    if (offerSkills.count == 0)
      percentage = 100
    else
      percentage = common * 100 / offerSkills.count
    end

    Application.create offer_id: offerId, user_id: applicantId, percentage: percentage
    redirect_to "/offers/"
  end

  def unsuscribe
    offerId = params[:id]
    applicantId = User.where(email: GlobalData.find(1).Email).first.id
    Application.where(user_id: applicantId, offer_id: offerId).first.destroy
    redirect_to "/offers"
  end
end

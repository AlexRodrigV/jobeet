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
    percentage = common * 100 / offerSkills.count

    Application.create offer_id: offerId, user_id: applicantId, percentage: percentage
    redirect_to "/offers/#{offerId}"
  end
end

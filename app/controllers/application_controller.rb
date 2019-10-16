class ApplicationController < ActionController::Base
  before_action :set_variables

  def set_variables
    @skills = Skill.all.map
    if !@var
      @var = GlobalData.find(1)
      @currentUserId = User.where(email:@var.Email).first.id
    end
    if !@var.reset
      @var.update('isConnected': false, 'Username': "toto", 'Email': "@", 'role': 0, 'reset': true, 'isAdminConnected': false)
    end
  end


  def authorize_recruiter
    redirect_to "/" unless @var.role == 2 || GlobalData.find(1).isAdminConnected
  end

  def authorize_profile(id)
    redirect_to "/" unless (@var.role == 2 || GlobalData.find(1).isAdminConnected || User.where(email: @var.Email).first.id == id.to_i)
  end

  def authorize_applicant
    redirect_to "/" unless @var.role == 1
  end

  def getPercentage(offerId, applicantId)
    offer = Offer.find(offerId)

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
    return percentage

  end
end

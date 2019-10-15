class EnterpriseController < ApplicationController
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

  def index
    @enterprise = Enterprise.find(1)
    @enterpriseOffers = []
    enterprise_id = User.where(email: @var.Email).first.enterprise_id
    Enterprise.find(enterprise_id).users.each do |userEnterprise|
      Offer.where(recruiter_id: userEnterprise.id).each do |offer|
        @enterpriseOffers.push(offer)
      end
    end
  end

  def create
    o = Offer.create title: params[:title], description: params[:description], recruiter_id: User.where(email: @var.Email).first.id, identifier: params[:title] + ((User.where("email= ?", @var.Email).first).id).to_s
    CometChatService.new(
      uid: params[:title] + ((User.where("email= ?", @var.Email).first).id).to_s,
      name: o.title
    ).create_user
    skills = params[:skills]
    if (skills)
      skills.each do |skill|
        SkillOffer.create offer_id:o.id, skill_id:Skill.where(name:skill).first.id
      end
    end
    redirect_to '/enterprise'
  end


  def show
    @offer = Offer.find(params[:id])
    users = User.where.not(isRecruiter: true, situation: 0)
    @maxPrinted = [10, users.length - Application.where(offer_id: @offer.id).length].min
    @percentages = Array.new(@maxPrinted, 0)
    @suggestions = Array.new(@maxPrinted, nil)
    users.each do |user|
      if (Application.where(user_id: user.id, offer_id: @offer.id).exists? == false)
        percentage = getPercentage(@offer.id, user.id)
        if (percentage >= @percentages.last)
          @percentages[@maxPrinted-1] = percentage
          @suggestions[@maxPrinted-1] = user
          for i in ((@maxPrinted-2).downto(0))
            if percentage < @percentages[i]
              @percentages[i+1] = percentage
              @suggestions[i+1] = user
              break
            elsif i == 0
              @percentages[i+1] = @percentages[i]
              @suggestions[i+1] = @suggestions[i]
              @percentages[i] = percentage
              @suggestions[i] = user
            else
              @percentages[i+1] = @percentages[0]
              @suggestions[i+1] = @suggestions[0]
            end
          end
        end
      end
    @applications = Application.all.order(:percentage)
  end

  def delete
    Offer.find(params[:id]).destroy
    redirect_to '/enterprise'
  end

  def change
    @offer = Offer.find(params[:id])
  end

  def update
    o = Offer.find(params[:id])
    o.update nbModifications:o.nbModifications+1
    o.update title: params[:title], description: params[:description]

    skills = params[:skills]
    if (skills)
      skills.each do |skill|
        SkillOffer.create offer_id:o.id, skill_id:Skill.where(name:skill).first.id
      end
    end
    redirect_to "/enterprise/#{params[:id]}"
  end


end
end

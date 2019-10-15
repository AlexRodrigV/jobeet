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
    recruiter = User.where(email: GlobalData.find(1).Email).first
    @enterprise = Enterprise.find(recruiter.enterprise_id)
    @enterpriseOffers = []

    @enterprise.users.each do |userEnterprise|
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
    if @maxPrinted > 0
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
      end
    @applications = Application.all.order(:percentage)
  end

  def delete
    Offer.find(params[:id]).destroy
    redirect_to '/enterprise'
  end

  def change
    @offer = Offer.find(params[:id])

    @notAvailableSkills = []
    @offer.skills.each do |skill|
      @notAvailableSkills.push(skill.name)
    end

    @availableSkills = []
    Skill.all.each do |skill|
      if (!@notAvailableSkills.include?(skill.name))
        @availableSkills.push(skill.name)
      end
    end
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
    skillsRemoved = params[:removeSkills]
    if skillsRemoved
      skillsRemoved.each do |elt|
        idToRemove = Skill.where(name: elt).first.id
        SkillUser.where(user_id: @currentUser.id, skill_id: idToRemove).first.delete
      end
    end
    redirect_to "/enterprise/#{params[:id]}"
  end

  def acceptSuggestion
    idAcceptedUser = params[:idAcceptSuggestion]
    tmp = User.find(idAcceptedUser).email.clone.gsub!(/[@.-_]/, '@' => "at", '.' => '', '-' => '', '_' => '').downcase
    Application.create offer_id: params[:idOffer], user_id: idAcceptedUser, percentage: getPercentage(params[:idOffer], idAcceptedUser), idchatuser: tmp, idchatoffer: Offer.find(params[:idOffer]).identifier, isAccepted: true
  end

  def acceptApplicant
    idAcceptedUser = params[:idAcceptApplicant]
    tmp = User.find(idAcceptedUser).email.clone.gsub!(/[@.-_]/, '@' => "at", '.' => '', '-' => '', '_' => '').downcase
    Application.where(offer_id: params[:idOffer], user_id: idAcceptedUser).first.update_columns(isAccepted: true)
  end

end
end

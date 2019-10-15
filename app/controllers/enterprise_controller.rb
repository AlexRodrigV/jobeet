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
    uidOffer = params[:title].clone.gsub!(/[@.-_ ]/, '@' => "at", '.' => '', '-' => '', '_' => '', ' ' => '') + ((User.where("email= ?", @var.Email).first).id).to_s
    o = Offer.create title: params[:title], description: params[:description], recruiter_id: User.where(email: @var.Email).first.id, identifier: uidOffer.downcase
    CometChatService.new(
      uid: uidOffer.downcase,
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
    @test = Array.new()
    @suggestions = Hash.new(0)
    users.each do |user|
      if Application.where(user_id: user.id, offer_id: @offer.id).exists? == false
        @suggestions[user] = getPercentage(@offer.id, user.id)
      end
    end
    @suggestions = @sugestions = @suggestions.sort_by { |k,v| v }.reverse

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

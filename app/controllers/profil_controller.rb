class ProfilController < ApplicationController
  def index
    if params[:id] == "-1"
      @currentUser = User.where("email= ?", @var.Email).first
    else
      @currentUser = User.find(params[:id])
    end
    @notAvailableSkills = []
    SkillUser.where(user_id: @currentUser.id).each do |elt|
      @notAvailableSkills.push(Skill.find(elt.skill_id).name)
    end
    @availableSkills = []
    @skills.each do |elt|
      puts(elt.name)
      if (!@notAvailableSkills.include?(elt.name))
        @availableSkills.push(elt.name)
      end
    end
  end

  def edit
    @currentUser = User.where("email= ?", @var.Email).first
    userId = @currentUser.id
    if(params[:skills])
      params[:skills].each do |skill|
        skillId = Skill.where(name: skill).first.id
        SkillUser.create user_id:userId, skill_id:skillId
      end
    end
    if(params[:removeSkills])
      params[:removeSkills].each do |elt|
        idToRemove = Skill.where(name: elt).first.id
        SkillUser.where(user_id: @currentUser.id, skill_id: idToRemove).first.delete
      end
    end


    if params[:off]
      situation = 0
    elsif params[:onsoft]
      situation = 1
    else
      situation = 2
    end
    User.where("email= ?", @var.Email).first.update_columns('description': params[:description], 'hobbies': params[:hobbies], 'company': params[:company], 'street': params[:street], 'city': params[:city], 'state': params[:state], 'resume': params[:resume], 'isPremium': params[:isPremium], 'situation': situation)
  end
end

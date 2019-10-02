class ProfilController < ApplicationController
  def index
    @currentUser = User.where("email= ?", @var.Email).first
  end

  def edit
    @currentUser = User.where("email= ?", @var.Email).first
    userId = @currentUser.id
    params[:skills].each do |skill|
      skillId = Skill.where(name: skill).first.id
      SkillUser.create user_id:userId, skill_id:skillId
    end
    User.where("email= ?", @var.Email).first.update_columns('description': params[:description], 'hobbies': params[:hobbies], 'company': params[:company], 'street': params[:street], 'city': params[:city], 'state': params[:state], 'resume': params[:resume])
  end
end

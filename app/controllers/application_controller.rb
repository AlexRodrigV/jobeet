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
    redirect_to "/" unless (@var.role == 2 || GlobalData.find(1).isAdminConnected || id == "-1" || User.where(email: @var.Email).first.id == id.to_i)
  end

  def authorize_applicant
    redirect_to "/" unless @var.role == 1
  end
end

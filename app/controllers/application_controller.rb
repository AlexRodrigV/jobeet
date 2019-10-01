class ApplicationController < ActionController::Base
  before_action :set_variables

  def set_variables
    @skills = Skill.all.map
    if !@var
      @var = GlobalData.find(1)
    end
    if !@var.reset
      @var.update('isConnected': false, 'Username': "toto", 'Email': "@", 'role': 0, 'reset': true)
    end
  end
end

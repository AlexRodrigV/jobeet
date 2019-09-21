class ApplicationController < ActionController::Base
  before_action :set_variables

  def set_variables
    @var = GlobalData.find(1)
    if $tmp == nil
      @var.update('isConnected': false, 'Username': "toto", 'Email': "@", 'role': 0)
      $tmp = 1
    end
  end

  def signout
    $tmp = nil
  end

  def applicant
    @var.update_columns('role': 1)
  end

  def recruiter
    @var.update_columns('role': 2)
  end

  helper_method :signout, :recruiter, :applicant

end

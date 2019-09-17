class ApplicationController < ActionController::Base
  before_action :set_variables

  def set_variables
    @var = GlobalData.find(1)
    if $tmp == nil
      @var.update_attributes('isConnected': false, 'Username': "toto", 'Email': "@")
      $tmp = 1
    end
  end

  def signout
    $tmp = nil
  end

  helper_method :signout

end

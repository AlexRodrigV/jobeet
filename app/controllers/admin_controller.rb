class AdminController < ApplicationController
  def index
  end

  def connection
    if params[:login] == "admin" && params[:pwd] == "stevejobs"
      GlobalData.find(1).update_columns(isAdminConnected: true)
    end
  end
end

class HomeController < ApplicationController
  def index
    @firstConnection = User.where(email: @var.Email).first.enterprise_id == nil
  end

      def applicant
        @var.update_columns('role': 1)
        redirect_to '/auth/google_oauth2'
        return
      end

      helper_method :applicant

      def recruiter
        @var.update_columns('role': 2)

      end

      helper_method :recruiter

      def addEnterprise
        e = Enterprise.where(name: params[:name]).first
        if !e
          e = Enterprise.create name: params[:name]
        end
        User.where(email:GlobalData.find(1).Email).first.update_columns(enterprise_id: e.id)
      end

      def signout
        redirect_to :controller => 'home', :action => 'index'
        @var.update('isConnected': false, 'Username': "toto", 'Email': "@", 'role': 0, 'reset': true)
        return
      end

      helper_method :signout
end

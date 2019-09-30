class HomeController < ApplicationController
  def index
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

      def signout
        redirect_to :controller => 'home', :action => 'index'
        @var.update('isConnected': false, 'Username': "toto", 'Email': "@", 'role': 0, 'reset': true)
        return
      end

      helper_method :signout
end

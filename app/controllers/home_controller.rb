class HomeController < ApplicationController
  def index
  end

      def applicant
        @var.update_columns('role': 1)
      end

      helper_method :applicant

      def recruiter
        @var.update_columns('role': 2)
      end

      helper_method :recruiter

      def signout
        @var.update('isConnected': false, 'Username': "toto", 'Email': "@", 'role': 0, 'reset': true)
      end

      helper_method :signout
end

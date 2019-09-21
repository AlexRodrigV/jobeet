class HomeController < ApplicationController
  def index
  end

private

    def applicant
      @var.update_columns('role': 1)
      puts("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
    end

    helper_method :applicant

    def recruiter
      @var.update_columns('role': 2)
    end

    helper_method :recruiter

    def signout
      @var.update_columns('reset': false)
    end

    helper_method :signout
end

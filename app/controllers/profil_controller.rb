class ProfilController < ApplicationController
  def index
    @currentUser = User.where("email= ?", @var.Email).first
  end
end

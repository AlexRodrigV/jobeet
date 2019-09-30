class ProfilController < ApplicationController
  def index
    @currentUser = User.where("email= ?", @var.Email).first
  end

  def edit
    User.where("email= ?", @var.Email).first.update_columns('description': params[:description], 'hobbies': params[:hobbies], 'company': params[:company], 'street': params[:street], 'city': params[:city], 'state': params[:state], 'resume': params[:resume])
    @currentUser = User.where("email= ?", @var.Email).first
  end
end
  

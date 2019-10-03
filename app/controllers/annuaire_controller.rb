class AnnuaireController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @users = User.all
  end
end

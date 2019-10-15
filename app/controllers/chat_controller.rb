class ChatController < ApplicationController
  def index
    @chatLoggedName = @var.Username
    @chatLoggedId = @var.Email.clone.gsub!(/[@.-_]/, '@' => "at", '.' => '', '-' => '', '_' => '').downcase
    if @var.role == 2
      @chatLoggedName = Offer.find(params[:id]).title
      @chatLoggedId = Offer.find(params[:id]).identifier
    end
    users = CometChatService.new.fetch_users
    emailchat = @var.Email.clone.gsub!(/[@.-_]/, '@' => "at", '.' => '', '-' => '', '_' => '').downcase
    @users = users.reject { |u| u[:id] == emailchat }
    if @var.role == 1
      users.each do |elt|
        if !Application.where(idchatuser: emailchat, idchatoffer: elt[:id], isAccepted: true).exists?
          @users = @users.reject { |u| u[:id] == elt[:id] }
        end
      end
    else
      users.each do |elt|
        if !Application.where(idchatuser: elt[:id], idchatoffer: @chatLoggedId, isAccepted: true).exists?
          @users = @users.reject { |u| u[:id] == elt[:id] }
        end
      end
    end
  end

  def new; end

  def create
    user = CometChatService.new(user_params).create_user
    if user['uid']
      message = 'Your user was saved. You are ready to start chatting!'
      redirect_to user_path(user['uid']), alert: message
    else
      message = 'Sorry, that did not work'
      redirect_to new_user_path, alert: message
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end

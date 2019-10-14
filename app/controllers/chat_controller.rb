class ChatController < ApplicationController
  def index
    users = CometChatService.new.fetch_users
    emailchat = @var.Email.clone.gsub!(/[@.-_]/, '@' => "at", '.' => '', '-' => '', '_' => '')
    @users = users.reject { |u| u[:id] == emailchat }
    if @var.role == 1
      users.each do |elt|
        if !Application.where(idchatuser: emailchat, idchatoffer: elt[:id], isAccepted: true).exists?
          @users = @users.reject { |u| u[:id] == elt[:id] }
        end
      end
    else
      tmp = []
      enterprise_id = User.where(email: @var.Email).first.enterprise_id
      Enterprise.find(enterprise_id).users.each do |userEnterprise|
        Offer.where(recruiter_id: userEnterprise.id).each do |offer|
          tmp.push(users.find { |u| u[:id] == offer.identifier })
          if Application.where(idchatoffer: offer.identifier).exists?
            puts(users.find { |u| u[:id] == offer.identifier })
          end
        end
      end
      puts(tmp)
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

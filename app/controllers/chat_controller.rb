class ChatController < ApplicationController
  def index
    users = CometChatService.new.fetch_users
    @my_user = users.find { |u| u[:id] == params[:id] }
    @users = users.reject { |u| u[:id] == @var.Email }
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

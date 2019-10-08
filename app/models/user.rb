class User < ApplicationRecord
  has_many :applications
  has_many :offers
  has_many :skillUsers
  def self.from_omniauth(auth)
    @var = GlobalData.find(1)
    @var.update_columns('isConnected': true, 'Username': auth.info.name, 'Email': auth.info.email, 'image': auth.info.image)
    # Creates a new user only if it doesn't exist
    tmp = auth.info.email.clone
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.image = auth.info.image
      new_user = CometChatService.new(
        uid: tmp.gsub!(/[@.-_]/, '@' => "at", '.' => '', '-' => '', '_' => ''),
        name: auth.info.name
      ).create_user
    end
  end
end

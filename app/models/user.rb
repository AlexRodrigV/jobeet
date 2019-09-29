class User < ApplicationRecord
  def self.from_omniauth(auth)
    @var = GlobalData.find(1)
    @var.update_columns('isConnected': true, 'Username': auth.info.name, 'Email': auth.info.email, 'image': auth.info.image)
    # Creates a new user only if it doesn't exist
    where(email: auth.info.email).first_or_initialize do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.image = auth.info.email
    end
  end
end

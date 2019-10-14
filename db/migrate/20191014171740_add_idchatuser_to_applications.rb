class AddIdchatuserToApplications < ActiveRecord::Migration[6.0]
  def change
    add_column :applications, :idchatuser, :string
  end
end

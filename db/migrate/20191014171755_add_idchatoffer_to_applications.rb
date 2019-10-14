class AddIdchatofferToApplications < ActiveRecord::Migration[6.0]
  def change
    add_column :applications, :idchatoffer, :string
  end
end

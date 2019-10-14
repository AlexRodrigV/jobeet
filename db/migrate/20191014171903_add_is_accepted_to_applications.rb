class AddIsAcceptedToApplications < ActiveRecord::Migration[6.0]
  def change
    add_column :applications, :isAccepted, :boolean
  end
end

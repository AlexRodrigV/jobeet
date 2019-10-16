class AddIsAdminConnectedToGlobalData < ActiveRecord::Migration[6.0]
  def change
    add_column :global_data, :isAdminConnected, :boolean
  end
end

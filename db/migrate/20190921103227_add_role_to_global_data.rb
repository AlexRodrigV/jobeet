class AddRoleToGlobalData < ActiveRecord::Migration[6.0]
  def change
    add_column :global_data, :role, :int
  end
end

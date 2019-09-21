class AddResetToGlobalData < ActiveRecord::Migration[6.0]
  def change
    add_column :global_data, :reset, :boolean
  end
end

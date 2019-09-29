class AddImageToGlobalData < ActiveRecord::Migration[6.0]
  def change
    add_column :global_data, :image, :string
  end
end

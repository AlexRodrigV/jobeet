class AddLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :applications
    add_column :applications, :offer_id, :integer
    add_column :applications, :user_id, :integer




  end
end

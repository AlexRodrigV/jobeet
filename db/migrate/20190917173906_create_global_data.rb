class CreateGlobalData < ActiveRecord::Migration[6.0]
  def change
    create_table :global_data do |t|
      t.boolean :isConnected
      t.string :Username
      t.string :Email
      t.integer :user_id

      t.timestamps
    end
  end
end

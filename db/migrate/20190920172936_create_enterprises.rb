class CreateEnterprises < ActiveRecord::Migration[6.0]
  def change
    create_table :enterprises do |t|
      t.string :name

      t.integer :user_id
    end
  end
end

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.boolean :isRecruiter
      t.boolean :isPremium, :default => false
      t.integer :situation, :default => 2 #0=OFF, 1=ON-SOFT, 2=ON-HARD

      t.integer :enterprise_id

      t.timestamps
    end
  end
end

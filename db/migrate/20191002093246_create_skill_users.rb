class CreateSkillUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :skill_users do |t|
      t.integer :skill_id
      t.integer :user_id
    end
  end
end

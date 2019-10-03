class UpdateFieldSkills < ActiveRecord::Migration[6.0]
  def change
    add_index :Skills, :name, unique: true
  end
end

class AddHobbiesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :hobbies, :string
  end
end

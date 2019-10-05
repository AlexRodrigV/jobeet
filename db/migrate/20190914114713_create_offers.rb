class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :title
      t.text :description
      t.string :keywords
      t.integer :nbModifications, :default => 0

      t.integer :recruiter_id


      t.timestamps
    end
  end
end

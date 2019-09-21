class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :title
      t.text :text
      t.string :keywords
      

      t.timestamps
    end
  end
end

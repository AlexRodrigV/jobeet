class CreateSkillOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :skill_offers do |t|
      t.integer :skill_id
      t.integer :offer_id
    end
  end
end

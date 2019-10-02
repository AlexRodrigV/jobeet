class Skill < ApplicationRecord
  has_many :skillOffers
  has_many :skillUsers
end

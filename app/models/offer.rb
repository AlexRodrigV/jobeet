class Offer < ApplicationRecord
  has_many :applications
  has_many :skillOffers
  has_many :skills, :through => :skillOffers

end

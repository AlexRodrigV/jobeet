class Offer < ApplicationRecord
  has_many :applications
  has_many :skillOffers
end

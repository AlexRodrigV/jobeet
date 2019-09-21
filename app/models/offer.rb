class Offer < ApplicationRecord
  validates :title, presence: true,
                    length: { minimum: 5 }
  
  belongs_to :recruiter

  has_many :applications
  has_many :employees , :though => applications

end

class Recruiter < ApplicationRecord
  belongs_to :enterprise
  has_many :offers
end

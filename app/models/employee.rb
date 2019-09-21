class Employee < ApplicationRecord
  has_many :applications
  has_many :offers, :though => applications
end

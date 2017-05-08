class Meetup < ApplicationRecord
  attr_encrypted :verification_code, key: ENV.fetch("MEETUP_SECRET")
  validates_presence_of :meetup_date

  has_many :attendances
  has_many :users, through: :attendances
end

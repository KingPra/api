class Token < ApplicationRecord
  before_validation :generate_token

  validates_presence_of :token, :description

  def self.valid?(str)
    Token.pluck(:token).include? str
  end

  private

  def generate_token
    self.token = SecureRandom.hex(64)
  end
end

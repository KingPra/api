class User < ApplicationRecord
  has_many :events
  has_many :credits, through: :events
  has_many :cred_steps

  after_initialize :build_cred_steps

  # Usage:
  #
  # User.fetch_user(github_handle: "foobar")
  # => User:0x007f990e64abc8
  #
  # Returns the unknown user if no user is found.
  #
  def self.fetch_user(opts)
    search, value = opts.to_a.flatten
    User.find { |u| u.info[search.to_s] == value } || User.unknown_user
  end

  def self.unknown_user
    Rails.cache.fetch(:unknown_user) do
      User.find_by!(email: "unknown")
    end
  end

  def self.leaderboard
    User.all.sort_by(&:credibility).reverse
  end

  def credibility
    credits.pluck(:points).reduce(&:+) || 0.0
  end

  validates_uniqueness_of :email

  private

  def build_cred_steps
    return unless cred_steps.empty?

    self.cred_steps = Credit.pluck(:id).map do |int|
      CredStep.new(credit_id: int)
    end
  end
end

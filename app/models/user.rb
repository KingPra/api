class User < ApplicationRecord
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

  validates_uniqueness_of :email
end

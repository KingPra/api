class User < ApplicationRecord
  has_many :events
  has_many :credits, through: :events
  has_many :cred_transactions
  has_many :attendances
  has_many :meetups, through: :attendances

  after_create :create_new_account_event

  def self.unknown_user
    Rails.cache.fetch(:unknown_user) do
      User.find_by!(email: "unknown")
    end
  end

  def self.leaderboard
    User.all.sort_by(&:credibility).reverse
  end

  def credibility
    cred_transactions.pluck(:delta).flatten.reduce(&:+) || 0.0
  end

  validates_uniqueness_of :email
  validates_uniqueness_of :github_handle, if: Proc.new { |user| user.github_handle.present? }
  validates_presence_of :email, :first_name, :last_name

  private

  def create_new_account_event
    CreateEvent.call!(
      event_params: {
        category: "account_created",
        user_id:  id
      }
    )
  end
end

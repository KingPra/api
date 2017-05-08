class Event < ApplicationRecord
  belongs_to :user
  belongs_to :credit, optional: true

  before_validation :assign_credit
  validates_presence_of :category, :user_id

  delegate :points, to: :credit

  private

  def assign_credit
    Credit.find_by(name: category).tap do |c|
      self.credit = c
    end
  end
end

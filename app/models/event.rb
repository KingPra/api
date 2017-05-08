class Event < ApplicationRecord
  belongs_to :user
  belongs_to :credit, optional: true
  belongs_to :cred_line_item, optional: true

  after_initialize :assign_credit

  delegate :points, to: :credit

  private

  def assign_credit
    Credit.find_by(name: category).tap do |c|
      self.credit = c
    end
  end
end

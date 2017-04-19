class CredStep < ApplicationRecord
  STATUSES = %w(complete incomplete).freeze
  belongs_to :credit

  validates :status, inclusion: { in: STATUSES }

  def complete!
    update!(status: "complete")
  end

  STATUSES.each do |msg|
    define_method("#{msg}?") { status == msg }
  end
end

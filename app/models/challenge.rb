class Challenge < ApplicationRecord
  scope :for_repo, ->(r) { where(repo: r) }
  scope :repos, -> { pluck(:repo).uniq }
end

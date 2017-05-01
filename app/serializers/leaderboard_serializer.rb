class LeaderboardSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :credibility, :picture
end

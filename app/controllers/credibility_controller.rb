class CredibilityController < ApplicationController
  def index
    render json: User.leaderboard, each_serializer: LeaderboardSerializer
  end
end

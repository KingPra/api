class CredibilityController < ApplicationController
  def index
    render json: User.leaderboard
  end
end

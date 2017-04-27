class ChallengesController < ApplicationController
  def index
    render json: { challenges: Challenge.all }
  end
end

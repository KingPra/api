class ChallengesController < ApplicationController
  def index
    render json: { challeges: Challenge.all }
  end
end

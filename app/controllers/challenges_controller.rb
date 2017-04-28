class ChallengesController < ApplicationController
  def index
    render json: { challenges: Challenge.for_repo(params[:repo]) }
  end
end

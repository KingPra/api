class ChallengesController < ApplicationController
  def index
    if repo_params.present?
      render json: { challenges: Challenge.for_repo(params[:repo]) }
    else
      render json: current_user.cred_steps, root: "challenges"
    end
  end

  private

  def repo_params
    params[:repo]
  end
end

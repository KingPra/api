class ChallengesController < ApplicationController
  def index
    result = FetchIssues.call(repo: repo_params)
    if result.issues.present?
      render json: { challenges: result.issues }.as_json
    else
      render json: current_user.cred_steps, root: "challenges"
    end
  end

  private

  def repo_params
    params[:repo]
  end
end

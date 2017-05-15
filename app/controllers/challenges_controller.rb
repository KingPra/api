class ChallengesController < ApplicationController
  def index
    result = FetchIssues.call(repo: repo_params)
    if result.issues.present?
      render json: { challenges: result.issues }.as_json
    else
      head :not_found
    end
  end

  private

  def repo_params
    params[:repo]
  end
end

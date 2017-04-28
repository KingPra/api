class ReposController < ApplicationController
  def index
    render json: { repos: serialized_repos }
  end

  private

  def serialized_repos
    Challenge.repos.map do |repo|
      {
        name: repo.split("/").last,
        path: repo
      }
    end
  end
end

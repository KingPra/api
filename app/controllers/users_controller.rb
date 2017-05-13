class UsersController < ApplicationController
  # GET /users
  def index
    @users = if search?
               User.find_by(search_params)
             else
               User.all
             end

    if @users
      render json: @users
    else
      render json: { errors: { user: "not found" } }, status: :not_found
    end
  end

  # GET /users/1
  def show
    user = params[:id].present? ? User.find(params[:id]) : current_user
    render json: user
  end

  def update
    if current_user.update(user_params)
      render json: current_user
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :codewars_handle,
      :github_handle, :linkedin_url, :resume_site_url,
      :twitter_handle, :stackoverflow_url
    )
  end

  def search?
    params["search"].present? && params["value"].present?
  end

  def search_params
    {
      params["search"] => params["value"]
    }
  end

  def fetch_user
    User.find do |u|
      u.info[search_params] == value_params
    end
  end
end

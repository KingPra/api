class CredStepsController < ApplicationController
  before_action :set_user

  def index
    render json: @user.cred_steps
  end

  def update
    render json: { status: :not_implemented_yet }
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end

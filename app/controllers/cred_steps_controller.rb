class CredStepsController < ApplicationController
  def index
    render json: current_user.cred_steps
  end
end

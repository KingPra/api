class CredTransactionsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: user.cred_transactions
  end
end

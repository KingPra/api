class CreditsController < ApplicationController
  before_action :set_credit, only: [:show, :update, :destroy]

  # GET /credits
  def index
    render json: { credits: Credit.all }
  end

  # GET /credits/1
  def show
    render json: @credit
  end

  # POST /credits
  def create
    @credit = Credit.new(credit_params)

    if @credit.save
      render json: @credit, status: :created, location: @credit
    else
      render json: @credit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /credits/1
  def update
    if @credit.update(credit_params)
      render json: @credit
    else
      render json: @credit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /credits/1
  def destroy
    @credit.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit
      @credit = Credit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def credit_params
      params.require(:credit).permit(:name, :points, :has_many)
    end
end

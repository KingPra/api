class MeetupsController < ApplicationController
  def show
    meetup = Meetup.find_by(meetup_date: Date.today)

    if meetup
      render json: { meetup: meetup }, status: :ok
    else
      render json: { errors: { meetup: ["not found"] } }, status: :not_found
    end
  end
end

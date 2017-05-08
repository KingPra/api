class AttendanceController < ApplicationController
  def create
    result = RecordMeetupAttendance.call(build_meetup_context)
    if result.success?
      render json: { event: result.event }, status: :created
    else
      render json: { errors: result.errors }, status: :bad_request
    end
  end

  def new
    meetup = Meetup.find_by(meetup_date: Date.today)

    if meetup
      render json: { meetup: meetup }, status: :ok
    else
      render json: { errors: { meetup: ["no event today"] } }, status: :not_found
    end
  end

  private

  def build_meetup_context
    {
      verification_code: params[:verification_code],
      ip_address:        remote_ip,
      user_id:           current_user.id
    }
  end
end

class RecordMeetupAttendance
  include Interactor

  def call
    return if code && meetup && record_attendance && create_event
    context.fail!(errors: errors)
  end

  private

  def record_attendance
    return unless valid_verification_code?
    context.errors = attendance.errors unless attendance.valid?
    attendance.save
  rescue ActiveRecord::RecordNotUnique
    context.errors = { attendance: "already exists" }
    false
  end

  def valid_verification_code?
    code == meetup.verification_code
  end

  def attendance
    context.attendance ||= Attendance.new(user_id: user.id, meetup_id: meetup.id)
  end

  def create_event
    result = CreateEvent.call(event_params: build_event_params)
    context.event = result.event
    return context.event if result.success?
    context.errors = result.errors
    false
  end

  def build_event_params
    {
      category: "meetup_attendance",
      user_id:  context.user_id
    }
  end

  def remote_ip
    context.remote_ip
  end

  def code
    context.verification_code
  end

  def user
    context.user ||= User.find(context.user_id)
  end

  def meetup
    context.meetup ||= Meetup.find_by(meetup_date: Date.today)
    return context.meetup if context.meetup
    context.errors = { meetup: ["does not exist"] }
    false
  end

  def errors
    context.errors ||= { verification_code: ["invalid"] }
  end
end

class UpdateUserCodewarsHonor
  include Interactor

  CODEWARS_API_URL = "https://codewars.com/api/v1".freeze
  CODEWARS_API_TOKEN = ENV.fetch("CODEWARS_API_TOKEN")

  def call
    return unless codewars_handle.present?
    context.response = fetch_user_info
    bounce_404_response
    context.honor = context.response["honor"]
    update_user
  end

  private

  def codewars_handle
    context.codewars_handle ||= user&.codewars_handle
  end

  def user
    context.user
  end

  def fetch_user_info
    HTTParty.get("#{CODEWARS_API_URL}/users/#{codewars_handle}", headers: headers)
  end

  def headers
    { "Authorization" => CODEWARS_API_TOKEN }
  end

  def bounce_404_response
    return unless context.response["success"] == false
    context.fail!(errors: [{ codewars_handle: context.response["reason"] }])
  end

  def update_user
    return if user.update(codewars_honor: context.honor)
    context.fail!(errors: user.errors.messages)
  end
end

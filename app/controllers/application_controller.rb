class ApplicationController < ActionController::API
  include ActionController::Serialization
  before_action :authenticate_request!

  attr_reader :current_user

  private

  def authenticate_request!
  ensure
    unless valid_client_request || valid_api_request
      render json: { errors: ["Not Authorized"] }, status: :unauthorized
    end
  end

  def valid_client_request
    return unless jwt_token
    payload = JsonWebToken.decode(jwt_token)
    email   = payload.fetch("email")
    @current_user = User.find_by(email: email)
    @current_user.present?
  rescue JWT::VerificationError, JWT::DecodeError
    nil
  end

  def valid_api_request
    Token.valid? auth_token
  end

  def auth_token
    return unless jwt_token
    @auth_token ||= JsonWebToken.decode(jwt_token).fetch("token") { :not_defined }
  rescue JWT::VerificationError, JWT::DecodeError
    nil
  end

  def jwt_token
    authorization_header = request.headers["Authorization"]
    return unless authorization_header.present?
    @jwt_token ||= authorization_header.split(" ").last
  end
end

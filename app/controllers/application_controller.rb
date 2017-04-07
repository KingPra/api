class ApplicationController < ActionController::API
  before_action :authenticate_request!

  private

  def authenticate_request!
  ensure
    unless valid_request
      render json: { errors: ["Not Authorized"] }, status: :unauthorized
    end
  end

  def valid_request
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

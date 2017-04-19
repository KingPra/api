class SessionController < ApplicationController
  skip_before_action :authenticate_request!, only: [:create]

  def create
    result = CreateSession.call(google_oauth_hsh)
    jwt    = result.token
    render json: { token: jwt }, status: :created
  rescue
    render json: { errors: ["Not Authorized"] }, status: :unauthorized
  end

  private

  def google_oauth_hsh
    @google_oauth_hsh ||= JSON.parse Base64.decode64(google_info_base64)
  end

  def google_info_base64
    @google_info_base64 ||= jwt_token.split(".").second
  end

  def jwt_token
    authorization_header = request.headers["Authorization"]
    return unless authorization_header.present?
    @jwt_token ||= authorization_header.split(" ").last
  end
end

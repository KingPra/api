class GithubWebhooksController < ApplicationController
  skip_before_action :authenticate_request!, only: :create
  before_action :authenticate_github_webhook, only: :create

  def create
    result = RecordGithubEvent.call(request: request)

    if result.success?
      render json: { event: result.event }, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def authenticate_github_webhook
    request.body.rewind
    payload_body = request.body.read
    hmac         = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), ENV.fetch("GITHUB_WEBHOOK_TOKEN"), payload_body)
    signature    = "sha1=#{hmac}"
    return if Rack::Utils.secure_compare(signature, request.env["HTTP_X_HUB_SIGNATURE"])
    render json: { error: "Signatures didn't match!" }
  end
end

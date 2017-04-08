class JsonWebToken
  SECRET = Rails.application.secrets.fetch(:jwt_secret)

  def self.encode(payload)
    JWT.encode(payload, SECRET)
  end

  def self.decode(token)
    HashWithIndifferentAccess.new(JWT.decode(token, SECRET).first)
  end
end

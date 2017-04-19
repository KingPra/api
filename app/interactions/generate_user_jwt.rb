class GenerateUserJWT
  include Interactor

  def call
    return unless user
    context.token = JsonWebToken.encode(payload)
  end

  private

  def user
    context.user
  end

  def payload
    {
      exp:   expiration,
      email: user.email
    }
  end

  def expiration
    context.expiration ||= 2.hours.from_now.to_i
  end
end

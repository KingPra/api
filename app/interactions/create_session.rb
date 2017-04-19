class CreateSession
  include Interactor

  # This class will be given a google oauth hash that looks like this:
  #
  # {
  #   "sub"=>"114357223",
  #   "email"=>"email@gmail.com",
  #   "email_verified"=>true,
  #   "at_hash"=>"xs6cccccicItk9vReRGGLg",
  #   "iss"=>"accounts.google.com",
  #   "iat"=>1492625112,
  #   "exp"=>1492628712,
  #   "name"=>"John Mason",
  #   "picture"=>"https://lh5.googleusercontent.com/-5Z/photo.jpg",
  #   "given_name"=>"Joe",
  #   "family_name"=>"Blow",
  #   "locale"=>"en"
  # }
  #
  def call
    return if generate_token
    context.fail!(errors: context.errors)
  end

  private

  def generate_token
    result         = ::GenerateUserJWT.call(user: user)
    context.errors = result.errors if result.failure?
    context.token  = result.token
  end

  def user
    context.user ||= find_or_create_user
  end

  def find_or_create_user
    User.find_or_create_by!(email: context.email) do |user|
      user.first_name = context.given_name
      user.last_name  = context.family_name
      user.picture    = context.picture
    end
  end
end

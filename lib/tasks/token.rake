desc "Generates/Fetches a valid JWT token"
task token: :environment do
  payload    = { email: "random@user.com" }
  jwt        = JsonWebToken.encode(payload)
  puts jwt
end

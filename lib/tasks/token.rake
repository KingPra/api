desc "Generates/Fetches a valid JWT token"
task :token do
  auth_token = Token.find_or_create_by!(description: "dev testing").token
  payload    = { token: auth_token }
  jwt        = JsonWebToken.encode(payload)
  puts jwt
end

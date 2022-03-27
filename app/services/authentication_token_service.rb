class AuthenticationTokenService
  HMAC_SECRET = 'my$ecretK3y'
  ALGORITHM_TYPE = 'HS256'

  def self.call(user_email)
    payload = { user_email: user_email }

    token = JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end
end 
class AuthenticationTokenService
  HMAC_SECRET = ENV['HMAC_SECRET']
  ALGORITHM_TYPE = ENV['ALGORITHM_TYPE']

  def self.encode(user_id)
    payload = { user_id: user_id }

    token = JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end

  def self.decode(token)
    decoded_token = JWT.decode(
      token,
      HMAC_SECRET,
      true,
      { algorithm: ALGORITHM_TYPE }
    )
    decoded_token[0]['user_id']
  rescue ActiveRecord::RecordInvalid => error
    raise InvalidError, error.message
  end

  class InvalidError < StandardError; end
end 
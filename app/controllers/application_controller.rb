class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  include ActionController::HttpAuthentication::Token

  private

  def not_destroyed(error)
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  def token
    token, _options = token_and_options(request)
    @token ||= token
  end

  def user_id
    @user_id ||= AuthenticationTokenService.decode(token)
  end

  def render_error(message, status_code)
    render json: { error: { message: message } }, status: status_code
  end
end

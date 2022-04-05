module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticationError < StandardError; end

      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from AuthenticationError, with: :handle_unauthenticated

      def create
        password = params.require(:password)

        raise AuthenticationError unless user.authenticate(password)
        token = AuthenticationTokenService.encode(user.id)

        render json: { token: token }, status: :created
      end

      def token_validation
        render json: { token: user_id }, status: :ok
      rescue AuthenticationTokenService::InvalidError
        head :unauthorized
      end

      private

      def user
        email = params.require(:email)
        @user ||= Users::FindService.new.by_email(email)
      end

      def parameter_missing(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end

      def handle_unauthenticated
        head :unauthorized
      end
    end
  end
end
module Api
  module V1
    class AuthenticationController < ApplicationController
      class AuthenticationError < StandardError; end

      rescue_from ActionController::ParameterMissing, with: :parameter_missing
      rescue_from AuthenticationError, with: :handle_unauthenticated

      def create
        email = params.require(:email)
        password = params.require(:password)

        user = User.find_by!(email: email)
        raise AuthenticationError unless user.authenticate(password)
        token = AuthenticationTokenService.call(user.email)

        render json: { token: token }, status: :created
      end

      private

      def parameter_missing(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end

      def handle_unauthenticated
        head :unauthorized
      end
    end
  end
end
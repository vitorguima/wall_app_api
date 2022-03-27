module Api
  module V1
    class AuthenticationController < ApplicationController
      rescue_from ActionController::ParameterMissing, with: :parameter_missing

      def create
        params.require(:email)
        params.require(:password)

        user = User.find_by!(email: params.require(:email))
        token = AuthenticationTokenService.call(user.email)

        render json: { token: token }, status: :created
      end

      private

      def parameter_missing(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end
    end
  end
end
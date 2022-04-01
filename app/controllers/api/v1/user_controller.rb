module Api
  module V1
    class UserController < ApplicationController
      include ActionController::HttpAuthentication::Token

      def create_user
        user = UserService.new_user(user_params)

        if user.save
          UserMailer.with(user: user).user_registered.deliver_later
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      def delete_user
        user = UserService.find_by_id(user_id).destroy!

        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :nickname, :password)
      end

      def token
        token, _options = token_and_options(request)
        @token ||= token
      end

      def user_id
        @user_id ||= AuthenticationTokenService.decode(token) unless token.nil?
      end
    end
  end
end
module Api
  module V1
    class UsersController < ApplicationController
      include ActionController::HttpAuthentication::Token

      def create_user
        user = Users::CreateService.new.call(user_params)
        render json: user, status: :created
      rescue Users::CreateService::InvalidError
        render json: user, status: :unprocessable_entity
      end

      def delete_user
        user = UserService.find_by_id(user_id).destroy!

        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :nickname, :password)
      end
    end
  end
end

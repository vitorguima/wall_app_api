module Api
  module V1
    class UsersController < ApplicationController
      include ActionController::HttpAuthentication::Token

      def create_user
        user = Users::CreateService.new.call(user_params)
        render json: user, status: :created
      rescue Users::CreateService::InvalidError => error
        render_error(error, :unprocessable_entity)
      end

      def delete_user
        Users::DeleteService.new.call(user_id)
        head :ok
      rescue Users::DeleteService::InvalidError
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :nickname, :password)
      end
    end
  end
end

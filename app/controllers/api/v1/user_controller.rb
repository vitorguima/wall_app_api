module Api
  module V1
    class UserController < ApplicationController
      def create_user
        user = User.new(user_params)

        if user.save
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :nickname, :password)
      end
    end
  end
end
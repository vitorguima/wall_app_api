module Api
  module V1
    class PostsController < ApplicationController
      include ActionController::HttpAuthentication::Token

      before_action :authenticate_user, only: [:create_post, :delete_post]

      def get_posts_list
        posts = Posts::ListService.new.call()
        render json: posts
      rescue Posts::ListService::InvalidError
        render json: post.errors, status: :unprocessable_entity
      end
    
      def create_post
        user = User.find(user_id)
        post = Posts::CreateService.new.call(user, post_params)
        render json: post, status: :created
      rescue Posts::CreateService::InvalidError
        render json: post.errors, status: :unprocessable_entity
      end
    
      def delete_post
        Posts::DeleteService.new.call(params[:post_id])

        head :ok
      end

      def update_post
        user = User.find(user_id)

        Posts::UpdateService.new.call(user, params[:post_id], post_params)

        head :ok
      end

      private

      def post_params
        request_params = params.require(:post).permit(:title, :content)
      end

      def authenticate_user
        # Authorization: Bearer <token>
        UserService.find_by_id(user_id)
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render status: :unauthorized
      end
    end
  end
end
module Api
  module V1
    class PostsController < ApplicationController
      include ActionController::HttpAuthentication::Token

      before_action :authenticate_user, only: [:create_post, :delete_post, :update_post, :list_by_user]

      def get_posts_list
        posts = Posts::ListService.new.call()
        render json: posts
      rescue Posts::ListService::InvalidError => error
        render_error(error, :unprocessable_entity)
      end
    
      def create_post
        post = Posts::CreateService.new.call(user_id, post_params)
        render json: post, status: :created
      rescue Posts::CreateService::InvalidError => error
        render_error(error, :unprocessable_entity)
      end
    
      def delete_post
        Posts::DeleteService.new.call(params[:post_id])
        head :ok
      rescue Posts::DeleteService::InvalidError
        render_error(error, :unprocessable_entity)
      end

      def update_post
        Posts::UpdateService.new.call(user_id, params[:post_id], post_params)
        head :created
      rescue Posts::UpdateService::InvalidError
        render_error(error, :unprocessable_entity)
      end

      def list_by_user
        posts = Posts::FindByUserService.new.call(user_id)
        render json: posts, status: :ok
      rescue Posts::FindByUserService::InvalidError
        render_error(error, :unprocessable_entity)
      end

      private

      def post_params
        request_params = params.require(:post).permit(:title, :content)
      end

      def authenticate_user
        Users::FindService.new.by_id(user_id)
      rescue ActiveRecord::RecordNotFound, AuthenticationTokenService::InvalidError
        render status: :unauthorized
      end
    end
  end
end
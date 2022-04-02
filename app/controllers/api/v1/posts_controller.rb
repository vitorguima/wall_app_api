module Api
  module V1
    class PostsController < ApplicationController
      include ActionController::HttpAuthentication::Token

      before_action :authenticate_user, only: [:create_post, :delete_post]

      def get_posts_list
        posts = PostsService.get_posts()

        render json: PostsRepresenter.new(posts).as_json
      end
    
      def create_post
        post = PostsService.new_post(post_params)
      
        if post.save
          render json: post, status: :created
        else
          render json: post.errors, status: :unprocessable_entity
        end
      end
    
      def delete_post
        post = PostsService.find_by_id(params[:id]).destroy!
        post.destroy!

        head :no_content
      end

      private

      def post_params
        request_params = params.require(:post).permit(:title, :content)
        request_params.merge(user_id: user_id)
      end

      def authenticate_user
        # Authorization: Bearer <token>
        UserService.find_by_id(user_id)
      rescue ActiveRecord::RecordNotFound, JWT::DecodeError
        render status: :unauthorized
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
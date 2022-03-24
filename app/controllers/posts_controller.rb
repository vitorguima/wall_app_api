class PostsController < ApplicationController
  def get_posts_list
    render json: Post.all
  end

  def create_post
    post = Post.new(post_params)

    if post.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def delete_post
    Post.find(params[:id]).destroy!

    head :no_content
  end
end 
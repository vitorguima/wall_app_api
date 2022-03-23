class PostsController < ApplicationController
  def get_posts_list
    render json: Post.all
  end

  def create_post
    post = Post.new(post_params)

    if post.save
      render json: post, status: :created
    else
      render json: book.errors, status: :unproccessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
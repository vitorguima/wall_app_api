class PostsController < ApplicationController
  def get_posts_list
    render json: Post.all
  end

  def create_post
    post = Post.new(title: 'test_method', content: 'test_curl')

    if post.save
      render json: post, status: :created
    else
      render json: book.errors, status: :unproccessable_entity
    end
  end
end
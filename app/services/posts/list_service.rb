module Posts
  class ListService
    def call
      posts = Post.order(created_at: :desc)
      PostsRepresenter.new(posts).as_json
    rescue ActiveRecord::RecordInvalid
      raise InvalidError, post.errors
    end

    class InvalidError < StandardError; end
  end
end
module Posts
  class DeleteService
    def call(post_id)
      Post.find(post_id).destroy!
    rescue ActiveRecord::RecordInvalid
      raise InvalidError, post.errors
    end

    class InvalidError < StandardError; end
  end
end
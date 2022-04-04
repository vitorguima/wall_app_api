module Posts
  class DeleteService
    def call(post_id)
      Post.find(post_id).destroy!
    rescue ActiveRecord::RecordInvalid => error
      raise InvalidError, error.message
    end

    class InvalidError < StandardError; end
  end
end
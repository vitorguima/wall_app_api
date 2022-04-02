module Posts
  class UpdateService
    def call(user, post_id, post_params)
      post = user.posts.find(post_id)
      post.update!(post_params)
    rescue ActiveRecord::RecordInvalid
      raise InvalidError, post.errors
    end

    class InvalidError < StandardError; end
  end
end
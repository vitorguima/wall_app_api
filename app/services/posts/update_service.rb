module Posts
  class UpdateService
    def call(user_id, post_id, post_params)
      user = Users::FindService.new.by_id(user_id)
      post = user.posts.find(post_id)
      post.update!(post_params)
    rescue ActiveRecord::RecordInvalid => error
      raise InvalidError, error.message
    end

    class InvalidError < StandardError; end
  end
end
module Posts
  class FindByUserService
    def call(user_id)
      user = Users::FindService.new.by_id(user_id)
      posts = user.posts.all
      PostsRepresenter.new(posts).as_json
    rescue ActiveRecord::RecordInvalid => error
      raise InvalidError, error.message
    end

    class InvalidError < StandardError; end
  end
end
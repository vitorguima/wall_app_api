module Posts
  class CreateService
    def call(user, params)
      posts = user.posts.create!(params).as_json
    rescue ActiveRecord::RecordInvalid
      raise InvalidError, posts.errors
    end

    class InvalidError < StandardError; end
  end
end
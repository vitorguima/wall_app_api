module Posts
  class CreateService
    def call(user_id, params)
      user = Users::FindService.new.by_id(user_id)
      posts = user.posts.create!(params).as_json
    rescue ActiveRecord::RecordInvalid => error
      raise InvalidError, error.message
    end

    class InvalidError < StandardError; end
  end
end
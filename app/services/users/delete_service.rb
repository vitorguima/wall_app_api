module Users
  class DeleteService
    def call(user_id)
      User.find(user_id).destroy!
    rescue ActiveRecord::RecordInvalid => error
      raise InvalidError, error.message
    end

    class InvalidError < StandardError; end
  end
end
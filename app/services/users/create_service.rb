module Users
  class CreateService
    def call(user_params)
      user = User.new(user_params)
      user.save!
      UserMailer.with(user: user).user_registered.deliver_later
      user.as_json
    rescue ActiveRecord::RecordInvalid => error
      raise InvalidError, error.message
    end

    class InvalidError < StandardError; end
  end
end
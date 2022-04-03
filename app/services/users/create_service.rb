module Users
  class CreateService
    def call(user_params)
      user = User.new(user_params)
      user.save!
      UserMailer.with(user: user).user_registered.deliver_later
      user.as_json
    rescue ActiveRecord::RecordInvalid
      raise InvalidError, user.errors.as_json
    end

    class InvalidError < StandardError; end
  end
end
module Users
  class FindService
    def by_email(email)
      user = User.find_by!(email: email)
    rescue ActiveRecord::RecordInvalid => error
      raise InvalidError, error.message
    end

    def by_id(id)
      user = User.find(id)
    rescue ActiveRecord::RecordInvalid => error
      raise InvalidError, error.message
    end

    class InvalidError < StandardError; end
  end
end
class UserService
  def self.find_by_id(user_id)
    user = User.find(user_id)
  end

  def self.new_user(params)
    new_user = User.new(params)
  end
end
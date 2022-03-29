class UserMailer < ApplicationMailer
  def initialize(user)
   @user = user
  end

  def user_registered
    @greeting = "Hello, #{user.first_name}"

    mail to: user.email
  end
end

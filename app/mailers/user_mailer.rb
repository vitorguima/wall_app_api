class UserMailer < ApplicationMailer
  def user_registered
    @user = params[:user]
    @url  = 'http://wordsonwall.com/login'

    mail(
      to: email_address_with_name(@user.email, @user.first_name),
      subject: "Welcome to the wall app!"
    )
  end
end

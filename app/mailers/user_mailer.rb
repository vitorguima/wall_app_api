class UserMailer < ApplicationMailer
  def user_registered
    @user = params[:user]
    @url  = 'https://wall-app-client.herokuapp.com/'

    mail(
      to: email_address_with_name(@user.email, @user.first_name),
      subject: "Welcome to the wall app!"
    )
  end
end

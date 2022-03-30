# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/user_registered
  def user_registered
    UserMailer.with(user: User.first).user_registered
  end

end

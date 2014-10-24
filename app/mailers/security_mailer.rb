class SecurityMailer < ActionMailer::Base
  default from: "noreply@questionbox.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.security_mailer.password_reset.subject
  #
  def password_reset(user, key)
    @user = user
    @key = key
    mail to: @user.email, subject: "Password reset for Question Box"
  end
end

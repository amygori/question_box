# Preview all emails at http://localhost:3000/rails/mailers/security_mailer
class SecurityMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/security_mailer/password_reset
  def password_reset
    SecurityMailer.password_reset(User.new(name: "Jimmy Dean",
                                           email: "jdean@example.org"), "FAKEKEY")
  end

end

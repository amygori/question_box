require 'test_helper'

class SecurityMailerTest < ActionMailer::TestCase
  should "send a password reset" do
    user = users(:one)
    mail = SecurityMailer.password_reset(user, "WHOOHOO")
    assert_equal "Password reset for Question Box", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@questionbox.com"], mail.from
  end

end

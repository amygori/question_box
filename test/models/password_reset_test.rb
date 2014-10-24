require 'test_helper'

class PasswordResetTest < ActiveSupport::TestCase
  context "a PasswordReset" do
    should belong_to(:user)

    should validate_presence_of(:user)
    should validate_presence_of(:email)

    should_not allow_value("BAD EMAIL").for(:email)
    should_not allow_value("@").for(:email)
    should_not allow_value("  clinton@example.org").for(:email)

    should "lookup user before validation" do
      password_reset = PasswordReset.new(email: users(:one).email)
      password_reset.valid?
      assert_equal users(:one), password_reset.user
    end

    should "set a key on a password reset before validation" do
      password_reset = PasswordReset.new
      password_reset.valid?
      assert_not_nil password_reset.key
    end
  end
end

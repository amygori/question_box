require 'test_helper'

class PasswordResetTest < ActiveSupport::TestCase
  context "a Password Reset" do
    should belong_to(:user)

    should validate_presence_of(:user)

    should "set a key on a password reset before validation" do
      password_reset = PasswordReset.new
      password_reset.valid?
      assert_not_nil password_reset.key
    end
  end


end

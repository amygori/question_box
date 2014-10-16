require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def check_bad_email(user, email)
    user.email = email
    assert user.invalid?, "User with bad email should not be valid"
    assert_not_empty user.errors[:email]
  end

  setup do
    @user = User.new
  end

  test "should have an email" do
    check_presence(@user, :email)
  end

  test "should have a case-insensitive unique email" do
    @user.email = users(:one).email.upcase
    assert @user.invalid?, "Email address should be unique"
    assert_not_empty @user.errors[:email]
  end

  test "should have a valid formatted email" do
    check_bad_email(@user, "BAD_EMAIL")
    check_bad_email(@user, "@")
    check_bad_email(@user, "    clinton@example.org")
  end

  test "should have a name" do
    check_presence(@user, :name)
  end

  test "should have a score" do
    check_presence(@user, :score)
  end

  test "should have an integer for score" do
    @user.score = 3.14
    assert @user.invalid?, "User should have an integer score"
    assert_not_empty @user.errors[:score]
  end

  test "should not have a negative score" do
    @user.score = -3
    assert @user.invalid?, "User should have a positive score"
    assert_not_empty @user.errors[:score]
  end

  test "should have many comments" do
    check_presence(@user, :comments)
  end

  test "should have many votes" do
    check_presence(@user, :votes)
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  subject { users(:one) }

  should validate_presence_of(:name)
  should validate_presence_of(:email)
  should validate_uniqueness_of(:email).case_insensitive
  should validate_presence_of(:score)
  should validate_numericality_of(:score)
         .only_integer
         .is_greater_than_or_equal_to(0)

  should_not allow_value("BAD EMAIL").for(:email)
  should_not allow_value("@").for(:email)
  should_not allow_value("  clinton@example.org").for(:email)

  should have_secure_password


  setup do
    @user = User.new
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

  should have_many(:questions)
  should have_many(:answers)
  should have_many(:votes)

end

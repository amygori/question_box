require 'test_helper'

class LoginTest < ActiveSupport::TestCase
  context "a login with an invalid email" do
    subject { Login.new(email: Faker::Internet.email, password: "") }

    should "not be authenticated" do
      refute subject.authenticated?
    end

    should "be invalid" do
      assert subject.invalid?
    end

    should "not have a user" do
      assert_nil subject.user
    end
  end

  context "a login with an invalid password" do
    subject { Login.new(email: users(:one).email, password: "") }

    should "not be authenticated" do
      refute subject.authenticated?
    end

    should "be invalid" do
      assert subject.invalid?
    end

    should "have a user" do
      assert_equal users(:one), subject.user
    end
  end

  context "a valid login" do
    subject { Login.new(email: users(:one).email, password: default_password) }

    should "be authenticated" do
      assert subject.authenticated?
    end

    should "be valid" do
      assert subject.valid?
    end

    should "have a user" do
      assert_equal users(:one), subject.user
    end
  end
end

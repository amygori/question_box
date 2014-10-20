require 'test_helper'

class RegisterAndLoginTest < ActionDispatch::IntegrationTest
  context "registration" do
    context "with a valid email and password" do
      setup do
        @name = Faker::Name.name
        @email = Faker::Internet.email
        @password = default_password
      end

      should "be able to register as a user" do
        assert_difference "User.count" do
          visit new_user_path
          fill_in "Name", with: @name
          fill_in "Email", with: @email
          fill_in "Password", with: @password
          fill_in "Password confirmation", with: @password
          click_on "Register"
        end

        assert_equal root_path, current_path
        assert page.has_content?("registered")
        assert page.has_content?("Logged in as #{@name}")
      end
    end
  end

  context "login" do
    context "with a valid email and password" do
      should "be able to login" do
        visit login_path
        fill_in "Email", with: users(:one).email
        fill_in "Password", with: default_password
        click_button "Login"

        assert_equal root_path, current_path
        assert page.has_content?("Logged in as #{users(:one).name}")
      end
    end
  end

  context "logout" do
    context "when logged in" do
      setup do
        login
      end

      should "be able to log out" do
        visit root_path
        click_on "Logout"

        assert_equal root_path, current_path
        assert page.has_content?("logged out")
      end
    end
  end
end

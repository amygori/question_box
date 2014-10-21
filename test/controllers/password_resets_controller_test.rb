require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase

    context "GET password_resets#new" do
      setup do
        get :new
      end

      should render_template("new")
      should respond_with(:ok)
    end

    context "POST password_resets#create" do
      context "with invalid data" do
        setup do
          post :create, email: "digdug"
        end

        should render_template("new")

        should eventually "have an invalid password_reset" do
          assert_invalid_model(:password_reset)

      end
    end

      context "with an email not in our system" do

      end

     context "with an email in our system" do

      end
    end
end
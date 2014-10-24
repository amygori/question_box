require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  context "GET password_resets#new" do
    setup do
      get :new
    end

    should render_template("new")
    should respond_with(:ok)
    should "instantiate a new password reset" do
      assert_not_nil assigns(:password_reset)
    end
  end

  context "POST password_resets#create" do
    context "with invalid data" do
      setup do
        post :create, password_reset: { email: "digdug" }
      end

      should render_template("new")

      should "have an invalid password_reset" do
        assert_invalid_model(:password_reset)
      end
    end

    context "with an email not in our system" do
      setup do
        post :create, password_reset: { email: "digdug@example.org" }
      end

      should "take us back to the homepage" do
        assert_redirected_to root_path
      end

      should "have an invalid password_reset" do
        assert_invalid_model(:password_reset)
      end
    end

    context "with an email in our system" do
      setup do
        post :create, password_reset: { email: users(:one).email }
      end

      should "take us back to the homepage" do
        assert_redirected_to root_path
      end

      should "have a saved password_reset" do
        assert_saved_model(:password_reset)
      end

      should "send an email" do
        email = ActionMailer::Base.deliveries.last
        assert_not_nil email
        assert_includes email.to, users(:one).email
        assert_equal "Password reset for Question Box", email.subject
      end
    end
  end

  context "GET password_resets#edit" do
    context "with a valid key" do
      setup do
        @password_reset = PasswordReset.new(email: users(:one).email)
        @password_reset.save!
        get :edit, :id => @password_reset.key
      end

      should render_template("edit")
      should respond_with(:ok)
    end

    context "with an invalid key" do
      should "raise record not found" do
        assert_raises(ActiveRecord::RecordNotFound) do
          get :edit, :id => "BAD_KEY"
        end
      end
    end
  end

  context "PATCH password_resets#update" do
    context "with an invalid key" do
      should "raise record not found" do
        assert_raises(ActiveRecord::RecordNotFound) do
          patch :update,
                id: "BAD_KEY",
                user: { password: "password",
                        password_confirmation: "password" }
        end
      end
    end

    context "with a valid key and invalid user data" do
      setup do
        @password_reset = PasswordReset.new(email: users(:one).email)
        @password_reset.save!
        patch :update,
              id: @password_reset.key,
              user: { password: "password2",
                      password_confirmation: "no-match" }
      end

      should render_template("edit")

      should "have an invalid user" do
        assert_invalid_model(:user)
      end
    end

    context "with a valid key and user data" do
      setup do
        @password_reset = PasswordReset.new(email: users(:one).email)
        @password_reset.save!
        patch :update,
              id: @password_reset.key,
              user: { password: "password2",
                      password_confirmation: "password2" }
      end

      should "redirect to home page" do
        assert_redirected_to root_path
      end

      should "expire the password reset" do
        assert assigns[:password_reset].expired?
      end
    end
  end
end

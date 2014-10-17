require 'test_helper'

class UserControllerTest < ActionController::TestCase
  def valid_user_attributes
    {name: Faker::Name.name,
     email: Faker::Internet.email,
     password: "password",
     password_confirmation: "password"
    }
  end
  test "should get new" do
    get :new
    assert_response :success
  end


  context "POST :create" do
    context "when I send invalid information"
    setup {post :create}

    should "re-render the form" do
      #the following test actually only tells you whether there is actually a response from the server
      #assert_response :ok #this is the rails server response for success
      #INSTEAD test whether content renders from the form: testing templates and layouts
      assert render :new
    end

    should "instantiate an invalid user object if I send invalid information" do
      assert assigns["user"], "Should have a user"
      assert assigns["user"].invalid?, "Should have an invalid user"
    end

    context "when I send valid information" do
      should "create a user" do
        user_attributes = valid_user_attributes
        post :create, {user: user_attributes}

        assert assigns["user"], "should have a user"
        assert assigns["user"].persisted?, "should have saved a user in the database"
        assert_equal user_attributes[:name], assigns["user"].name
      end
    end
  end



end

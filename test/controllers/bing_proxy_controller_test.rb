require 'test_helper'

class BingProxyControllerTest < ActionController::TestCase
  context "GET :get" do
    setup do
      VCR.use_cassette("bing") do
        get :get, :query => "test"
      end
    end

    should respond_with(:ok)

    should "return JSON" do
      assert_includes response.header['Content-Type'], 'application/json'
    end
  end
end

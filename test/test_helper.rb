require 'simplecov'
SimpleCov.start 'rails'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'faker'
require 'shoulda'
require 'capybara/rails'
require "email_spec"
require_relative 'support/test_password_helper'

Capybara.server_port = 31337
Capybara.current_driver = :selenium #will open up in browser when running integration tests

class ActiveSupport::TestCase
  include TestPasswordHelper

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order. need to use db cleaner gem
  fixtures :all
  self.use_transactional_fixtures: false

  def logged_in_session
    { current_user_id: users(:one).id }
  end
end

class ActionController::TestCase
  def assert_invalid_model(model_name)
    assert assigns[model_name], "Should have a #{model_name}"
    assert assigns[model_name].invalid?, "Should have an invalid #{model_name}"
  end

  def assert_saved_model(model_name)
    assert assigns[model_name], "Should have a #{model_name}"
    assert assigns[model_name].persisted?, "#{model_name} should be persisted"
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  include EmailSpec::Helpers
  include EmailSpec::Matchers

  def login(user = users(:one), password = default_password)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_button "Login"
  end
end

ActiveRecord::FixtureSet.context_class.send :include, TestPasswordHelper


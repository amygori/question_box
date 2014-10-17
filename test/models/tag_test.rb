require 'test_helper'

class TagTest < ActiveSupport::TestCase
  should validate_presence_of :name
  should have_and_belong_to_many :questions
end

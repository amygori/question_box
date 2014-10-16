require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  setup do
    @comment = Comment.new
  end

  test "should belong to a user" do
    check_presence(@comment, :user)
  end

end

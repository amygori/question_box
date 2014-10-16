require 'test_helper'

class VoteTest < ActiveSupport::TestCase

  setup do
    @vote = Vote.new
  end

  test "should belong to a user" do
    check_presence(@vote, :user)
  end

  test "should belong to a 'voteable'" do
    check_presence(@vote, :voteable)
  end

  test "should be positive or negative" do
    @vote.value = 1 || -1
    assert @vote.invalid?, "vote should be positive or negative"
    assert_not_empty @vote.errors[:value]
  end

  test ""
end

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

  test "should add 10 points to question user" do
    question = questions(:one)
    previous_score = question.user.score
    question.votes.create(value:1)
    question.user.reload
    puts "question score #{question.user.score}"
    assert_equal 10, question.user.score - previous_score
  end

  test "should add 10 points to answer user" do
    answer = answer(:one)
    previous_score = answer.user.score
    answer.votes.create(value:1)
    answer.user.reload
    puts "answer score #{answer.user.score}"
    assert_equal 10, answer.user.score - previous_score
  end
end

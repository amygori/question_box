require 'test_helper'

class VoteTest < ActiveSupport::TestCase
#This is my code

=begin
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
=end

  should belong_to(:user)
  should belong_to(:voteable)

  should validate_presence_of(:user)
  should validate_presence_of(:value)
  should validate_inclusion_of(:value).in_array([-1, 1])

  context "a vote" do
    setup do
      @voter = users(:voter)
      @vote = Vote.new(user: @voter)
    end

    should "not be on your own stuff" do
      @vote.voteable = Question.new(user: @voter)

      assert @vote.invalid?, "Cannot vote on your own stuff"
      assert_not_empty @vote.errors[:user]
    end

    should "be unique per user & voteable" do
      @vote.voteable = questions(:one)
      @vote.value = 1
      @vote.save!

      vote2 = users(:voter).votes.build(voteable: questions(:one), value: -1)
      refute vote2.valid?
      assert_includes vote2.errors[:user], "has already been taken"
    end
  end
end

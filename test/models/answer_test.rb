require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  setup do
    @answer = Answer.new
  end

  test "should have text" do
    check_presence(@answer, :text)
  end

  test "should have a user" do
    check_presence(@answer, :user)
  end

  test "should have a question" do
    check_presence(@answer, :question)
  end

  test "should only allow one chosen answer per question" do
    # In order to make sure only one answer can be chosen per question
    # I need to set a current answer for a question to be chosen.
    # I am using an answer from the fixtures.
    chosen_answer = answers(:one_for_question_one)
    chosen_answer.update(chosen: true)

    # I need to set my answer model under test to have the same question
    # as the answer from the fixtures, so that I can test that two answers
    # for the same question cannot be chosen.
    @answer.question = chosen_answer.question

    # Choose a second answer for the question.
    @answer.chosen = true

    assert @answer.invalid?, "Only one answer can be chosen per question"
    assert_not_empty @answer.errors[:chosen]
  end

  test "should allow it to be the first chosen answer" do
    question = questions(:one)
    answer = question.answers.build(chosen: true)

    answer.valid?
    assert_empty @answer.errors[:chosen]
  end

  test "should award its user 100 points when chosen" do
    question = questions(:one)
    answer = question.answers.first
    refute answer.chosen?

    # previous_score = answer.user.score
    # answer.update(chosen: true)
    # assert_equal 100, user.score - previous_score

    assert_difference 'answer.user.score', 100 do
      answer.update(chosen: true)
    end
  end

  test "should have many comments" do
    check_presence(@answer, :comments)
  end
end

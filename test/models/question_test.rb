require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  should validate_presence_of(:text)
  should validate_presence_of(:user)

  should belong_to(:user)
  should have_many(:answers)
  should have_many(:votes)

  context "Question class" do
    should "be able to query for all unanswered questions" do
      questions = Question.unanswered
      assert_includes questions, questions(:unanswered)

      questions.each do |question|
        assert_equal 0, question.answers.count
      end
    end

    should "be able to query for all answered questions" do
      questions = Question.answered
      assert_includes questions, questions(:answered)

      questions.each do |question|
        assert_not_equal 0, question.answers.count
      end
    end

    should "be able to get most recently answered questions" do
      question = Question.create!(user: users(:one), title: "How", text: "who")
      question.answers.create!(user: users(:two), text: "what")
      questions = Question.recently_answered

      assert_equal question, questions.first

      questions.each do |question|
        assert_not_equal 0, question.answers.count
      end
    end
  end

  context "a question" do
    subject { questions(:one) }
    setup do
      @question = questions(:one)
    end

    should "should know if it has been answered" do
      assert questions(:answered).answered?
      refute questions(:unanswered).answered?
    end

    should "should know if it has not been answered" do
      assert questions(:unanswered).unanswered?
      refute questions(:answered).unanswered?
    end

    should "know if it has a chosen answer" do
      @question.answers.update_all(chosen: false)
      refute @question.has_chosen_answer?, "has_chosen_answer? should be false"

      @question.answers.first.update(chosen: true)
      assert @question.has_chosen_answer?, "has_chosen_answer? should be true"
    end

    should "know its own score" do
      voter1 = users(:one)
      voter2 = users(:voter)
      @question.votes.create!(value: 1, user: voter1)
      @question.votes.create!(value: 1, user: voter2)

      assert_equal 2, @question.score
    end
  end

  test "should have many comments" do
    check_presence(@question, :comments)
  end
end

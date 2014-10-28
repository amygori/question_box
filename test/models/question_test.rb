require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  should validate_presence_of(:text)
  should validate_presence_of(:user)

  should belong_to(:user)
  should have_many(:answers)
  should have_many(:votes)
  should have_and_belong_to_many(:tags)

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

    context "with tags" do
      setup do
        @q1 = questions(:one)
        @q1.tag_list = "ruby, activerecord"
        @q1.save!

        @q2 = questions(:two)
        @q2.tag_list = "ruby, sprockets"
        @q2.save!
      end

      should "be able to find questions by tag" do
        assert_same_elements Question.tagged_with("ruby"), [@q1, @q2]
        assert_same_elements Question.tagged_with("sprockets"), [@q2]
      end

      should "be able to get tag counts" do
        tag_counts = Question.tag_counts
        assert_equal tag_counts[0].name, "ruby"
        assert_equal tag_counts[0].count, 2
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

    should "be able to set tags" do
      assert_empty @question.tags
      @question.tag_list = "ruby, activerecord"
      assert_equal 2, @question.tags.count
      assert_includes @question.tags.map(&:name), "ruby"
      assert_includes @question.tags.map(&:name), "activerecord"
    end

    should "know its tags' names" do
      @question.tag_list = "ruby, activerecord"
      assert_same_elements @question.tag_names, %w(ruby activerecord)
    end

    should "know its tag list" do
      @question.tag_list = "ruby, activerecord"
      assert_equal "ruby, activerecord", @question.tag_list
    end
  end

  test "should have many comments" do
    check_presence(@question, :comments)
  end
end

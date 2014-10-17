require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  should validate_presence_of(:title)
  should validate_presence_of(:text)
  should validate_presence_of(:user)

  should belong_to(:user)
  should have_many(:answers)
  should have_many(:votes)

  context "a question" do
    subject { questions(:one) }
    setup do
      @question = questions(:one)
    end

    should "know if it has a chosen answer" do
      @question.answers.update_all(chosen: false)
      refute @question.has_chosen_answer?, "has_chosen_answer? should be false"

      @question.answers.first.update(chosen: true)
      assert @question.has_chosen_answer?, "has_chosen_answer? should be true"
    end

    should "know its own score" do
      voter1 = users(:chet)
      voter2 = users(:voter)
      @question.votes.create!(:value => 1, :user => voter1)
      @question.votes.create!(:value => 1, :user => voter2)

      assert_equal 2, @question.score
    end
  end

  test "should have many comments" do
    check_presence(@question, :comments)
  end
end








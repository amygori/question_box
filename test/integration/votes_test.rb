require 'test_helper'

class VotesTest < ActionDispatch::IntegrationTest
  context "while logged in" do
    setup do
      login(users(:voter))
    end

    context "with a current question and answer" do
      setup do
        @question = questions(:answered)
        @answer = answers(:answer_one)
      end

      should "be able to vote on the question" do
        visit question_path(@question)
        within("#question_#{@question.id}") do
          click_on "upvote"
          assert find(".vote-count").has_content?("1")
          assert page.has_css?(".fa-thumbs-o-up")
        end
      end

      should "be able to vote on the answer" do
        visit question_path(@question)
        within("#answer_#{@answer.id}") do
          click_on "upvote"
          assert find(".vote-count").has_content?("1")
          assert page.has_css?(".fa-thumbs-o-up")
        end
      end
    end
  end
end

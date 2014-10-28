require 'test_helper'

class AnswersTest < ActionDispatch::IntegrationTest
  context "while logged in" do
    setup do
      login(users(:voter))
    end

    context "with a current question and answer" do
      setup do
        @question = questions(:one)
      end

      should "be able to add an answer" do
        visit question_path(@question)
        fill_in "answer_text", with: "My answer is pretty cool!"
        click_on "Answer"

        assert page.has_content?("My answer is pretty cool!")
      end
    end
  end
end

require 'test_helper'

class QuestionsTest < ActionDispatch::IntegrationTest
  context "Questions" do
    should "be able to view an individual question" do
      question = questions(:one)

      visit question_path(question)

      assert page.has_content?(question.title)
      assert page.has_content?(question.text)
    end

    should "be able to create a question" do
      title = "How do I?"
      text = "I don't even know"

      login
      visit root_path
      fill_in "question_title", with: title
      fill_in "question_text", with: text
      click_on "Ask"

      assert page.has_content?("question has been created")
      assert page.has_content?(title)
      assert page.has_content?(text)
    end
  end
end

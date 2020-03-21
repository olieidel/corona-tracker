require 'test_helper'

class QuestionnaireTest < ActiveSupport::TestCase
  test "sliding window doesn't return same client_uuid twice" do
    assert_changes("Questionnaire.sliding_window.length") do
      questionnaires(:one).update!(client_uuid: questionnaires(:two).client_uuid)
    end
  end
end

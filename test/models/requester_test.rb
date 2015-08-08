require 'test_helper'

class RequesterTest < ActiveSupport::TestCase
  test "it makes a request to find common phrases by state" do
    co = State.create!(name: "CO", full_name: "colorado")
    request = Requester.most_used_words_for_state(co)

    assert request.is_a?(Array)

    word_attrs = request.first

    assert word_attrs.has_key?(:ngram)
    assert word_attrs.has_key?(:count)
  end

  test "it formats the word attributes" do
    co = State.create!(name: "CO", full_name: "colorado")
    word_attrs = Requester.word_attrs(co)

    
  end
end

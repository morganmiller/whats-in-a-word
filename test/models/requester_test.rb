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

    assert word_attrs.is_a?(Array)

    first_word = word_attrs.first

    assert first_word[:word]
    assert first_word[:mentions]
    assert first_word[:state].is_a?(State)
  end

  test "it filters out the unwanted words" do
    co = State.create!(name: "CO", full_name: "colorado")
    request = Requester.most_used_words_for_state(co)

    assert_equal [], request.select {|hash| hash[:ngram] == "colorado" }
    assert_equal [], request.select {|hash| hash[:ngram] == "amendment" }
  end
end

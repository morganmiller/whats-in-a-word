require 'test_helper'

class WordTest < ActiveSupport::TestCase
  test "it finds an array of sentiments for associated quotes" do
    w = Word.create(word: "am")
    Quote.create(speaker: "me", body: "I am happy", sentiment: 5, word: w)
    Quote.create(speaker: "me", body: "I am sad", sentiment: -5, word: w)

    assert_equal [5, -5], w.congress_sentiments
  end

  test "it knows the percent of positive and negative quotes" do
    w = Word.create(word: "am")
    Quote.create(speaker: "me", body: "I am happy", sentiment: 5, word: w)
    Quote.create(speaker: "me", body: "I am sad", sentiment: -5, word: w)

    assert_equal 50, w.percent_positive
    assert_equal 50, w.percent_negative
  end

  test "it can find random quotes" do
    w = Word.create(word: "am")
    Quote.create(speaker: "me", body: "I am happy", sentiment: 5, word: w)
    Quote.create(speaker: "me", body: "I am sad", sentiment: -5, word: w)
    Quote.create(speaker: "me", body: "I am pretty awesome", sentiment: -5, word: w)

    assert_equal 3, w.random_quotes.length
  end
end

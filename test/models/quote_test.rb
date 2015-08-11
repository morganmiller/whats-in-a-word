require 'test_helper'

class QuoteTest < ActiveSupport::TestCase

  test "it belongs to a word" do
    w = Word.create(word: "word")
    q = Quote.create(speaker: "Me", body: "I am so quotable", word: w)

    assert_equal w, q.word
  end

  test "it belongs to a legislator" do
    l = Legislator.create(first_name: "Morgan")
    q = Quote.create(speaker: "Me", body: "I am so quotable", legislator: l)

    assert_equal l, q.legislator
  end

  test "it won't save without a speaker" do
    q = Quote.new(body: "I won't save")

    refute q.save
  end

  test "it has a unique body" do
    q = Quote.create(body: "I'm super unique")
    q2 = Quote.new(body: "I'm super unique")

    refute q2.save
  end

  test "it can make a snippet of itself based upon its associated word" do
    w = Word.create(word: "word")
    q = Quote.create(speaker: "Me", body: "I am so quotable but I am too long of a quote so this word will be selected from the quote body and there will be a fragment of 10 letters either which way", word: w)

    assert_equal "...but I am too long of a quote so this word will be selected from the quote body and there will...", q.snippet
  end

  test "it makes a snippet with word in beginning" do
    w = Word.create(word:"start")
    q = Quote.create(word: w, speaker: "Me", body: "start is at the start of this quote which means eventually it will get cut off, but it knows not to look for indices before the beginning")

    assert_equal "start is at the start of this quote which means eventually...", q.snippet
  end

  test "it makes a snippet with a word at the end" do
    w = Word.create(word: "end")
    q3 = Quote.create(word: w, speaker: "me", body: "I am going to be a very long quote that only gets cut off when it reached the word at the very very end.")

    assert_equal "...off when it reached the word at the very very end.", q3.snippet
  end
end

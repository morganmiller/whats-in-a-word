require 'test_helper'

class RequesterTest < ActiveSupport::TestCase
  test "it filters out the unwanted words" do
    co = State.create(name: "CO", full_name: "Colorado")
    leg = Legislator.create(first_name: "Jared",
                            last_name: "Polis",
                            bio_id: "P000598",
                            state: co)

    VCR.use_cassette("unwanted_word_filter") do
      request = Requester.most_used_words_for_legislator(leg)

      assert_equal [], request.select {|hash| hash[:ngram] == "colorado" }
      assert_equal [], request.select {|hash| hash[:ngram] == "amendment" }
    end
  end

  test "it finds words for a legislator" do
    co = State.create(name: "CO", full_name: "Colorado")
    leg = Legislator.create(first_name: "Jared",
                            last_name: "Polis",
                            bio_id: "P000598",
                            state: co)

    VCR.use_cassette("legislator_words") do
      request = Requester.most_used_words_for_legislator(leg)

      assert request.is_a?(Array)

      word_attrs = request.first

      assert word_attrs.has_key?(:ngram)
      assert word_attrs.has_key?(:count)
    end
  end

  test "it formats legislator word attributes" do
    co = State.create(name: "CO", full_name: "Colorado")
    leg = Legislator.create(first_name: "Jared",
                            last_name: "Polis",
                            bio_id: "P000598",
                            state: co)

    VCR.use_cassette("legislator_word_attributes") do
      word_attrs = Requester.leg_word_attrs(leg)

      assert word_attrs.is_a?(Array)

      first_word = word_attrs.first

      assert first_word[:word]
      assert first_word[:mentions]
      assert first_word[:legislator].is_a?(Legislator)
    end
  end

  test "it finds quotes by legislator" do
    state = State.create!(name: "CO", full_name: "colorado")
    word  = Word.create(word: "mountains", state: state)
    leg   = Legislator.create(first_name: "Jared",
                              last_name: "Polis",
                              bio_id: "P000598")

    VCR.use_cassette("quotes_by_leg") do
      request = Requester.quotes_by_legislator(word, leg)

      assert request.is_a?(Array)

      quote_attrs = request.first

      assert quote_attrs.has_key?(:speaking)
      assert quote_attrs.has_key?(:speaker_first)
      assert quote_attrs.has_key?(:speaker_last)
      assert quote_attrs.has_key?(:bioguide_id)
    end
  end

  test "it formats legislator quote attrs" do
    state = State.create!(name: "CO", full_name: "colorado")
    word = Word.create(word: "mountains", state: state)
    leg = Legislator.create(first_name: "Jared",
                            last_name: "Polis",
                            bio_id: "P000598")

    VCR.use_cassette("quotes_attrs_for_leg") do
      request = Requester.leg_quote_attrs(word, leg)

      assert request.is_a?(Array)

      first_quote = request.first

      assert first_quote.has_key?(:word)
      assert first_quote.has_key?(:body)
      assert first_quote.has_key?(:speaker)
      assert first_quote.has_key?(:bio_id)
      assert first_quote[:sentiment].is_a?(Float)
    end
  end

  test "it analyzes sentiments" do
    quote = "I am a very bad sentiment"

    assert_equal -0.527573529412, Requester.analyze_sentiment(quote)
  end
end

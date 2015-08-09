class Requester
  include HTTParty
  base_uri 'http://capitolwords.org/api/1'
  KEY = ENV['sunlight_key']

  def self.most_used_words_for_state(state)
    params = { query: {apikey: KEY,
                       entity_type: "state",
                       entity_value: state.name,
                       start_date: "2015-01-01",
                       sort: "count desc"}}

    words = self.get("/phrases.json", params).to_a.map(&:symbolize_keys)
    filter_unwanted_words(words, state).first(30)
  end

  def self.filter_unwanted_words(words, state)
    words.delete_if { |word| word[:ngram].include?(state.full_name.downcase) || word[:ngram] == "amendment" }
  end

  def self.word_attrs(state)
    most_used_words_for_state(state).map do |word_attrs|
      {word: word_attrs[:ngram],
       mentions: word_attrs[:count],
       state: state
      }
    end
  end

  def self.quotes_by_word(word, state)
    params = { query: {apikey: KEY,
                       phrase: word,
                       speaker_state: state,
                       start_date: "2015-01-01",
                       per_page: "1500"}}

    self.get("/text.json", params).parsed_response["results"].map(&:symbolize_keys)
  end

  def self.quote_attrs(word, state)
    quotes_by_word(word, state).map do |quote_attrs|
      {word: word,
       body: quote_attrs[:speaking].first,
       speaker: "#{quote_attrs[:speaker_first]} #{quote_attrs[:speaker_last]}",
       sentiment: analyze_sentiment(quote_attrs[:speaking].first)
      }
    end
  end

  def self.analyze_sentiment(quote)
    Sentimental.load_defaults
    Sentimental.new.get_score(quote)
  end
end

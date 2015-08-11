class Requester
  include HTTParty
  base_uri 'http://capitolwords.org/api/1'
  KEY = ENV['sunlight_key']

  def self.phrases_query(params)
    self.get("/phrases.json", params).to_a.map(&:symbolize_keys)
  end

  def self.text_query(params)
    self.get("/text.json", params).parsed_response["results"].map(&:symbolize_keys)
  end

  def self.most_used_words_for_state(state)
    params = { query: {apikey: KEY,
                       entity_type: "state",
                       entity_value: state.name,
                       start_date: "2015-01-01",
                       sort: "count desc"}}

    filter_unwanted_words(phrases_query(params), state).first(30)
  end

  def self.most_used_words_for_legislator(leg)
    params = { query: {apikey: KEY,
                       entity_type: "legislator",
                       entity_value: leg.bio_id,
                       sort: "count desc"}}

    phrases_query(params).first(30)
  end

  def self.filter_unwanted_words(words, state)
    lame_words = ["amendment", "thing", "maybe"]
    words.delete_if do |word|
      word[:ngram].include?(state.full_name.downcase) || lame_words.include?(word[:ngram])
    end
  end

  def self.word_attrs(state)
    most_used_words_for_state(state).map do |word_attrs|
      { word: word_attrs[:ngram],
        mentions: word_attrs[:count],
        state: state
      }
    end
  end

  def self.leg_word_attrs(leg)
    most_used_words_for_legislator(leg).map do |word_attrs|
      { word: word_attrs[:ngram],
        mentions: word_attrs[:count],
        legislator: leg
      }
    end
  end

  def self.quotes_by_word(word, state)
    params = { query: { apikey: KEY,
                        phrase: word.word,
                        speaker_state: state.name,
                        start_date: "2015-01-01",
                        per_page: "500"}}

    text_query(params)
  end

  def self.quotes_by_legislator(word, leg)
    params = { query: { apikey: KEY,
      phrase: word.word,
      bioguide_id: leg.bio_id,
      per_page: "100"}}

    text_query(params)
  end

  def self.quote_attrs(word, state)
    quotes_by_word(word, state).map do |quote_attrs|
      common_quote_attrs(word, quote_attrs)
    end
  end

  def self.leg_quote_attrs(word, leg)
    quotes_by_legislator(word, leg).map do |quote_attrs|
      common_quote_attrs(word, quote_attrs)
    end
  end

  def self.common_quote_attrs(word, quote_attrs)
    { word: word,
      body: quote_attrs[:speaking].join(" "),
      speaker: "#{quote_attrs[:speaker_first]} #{quote_attrs[:speaker_last]}",
      bio_id: quote_attrs[:bioguide_id],
      sentiment: analyze_sentiment(quote_attrs[:speaking].join(" "))
    }
  end

  def self.analyze_sentiment(quote)
    Sentimental.load_defaults
    Sentimental.new.get_score(quote)
  end
end

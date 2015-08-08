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

    words = self.get("/phrases.json", params).to_a
    words.delete_if { |word| word["ngram"].include?(state.full_name.downcase) || word == "amendment" }
    words.first(30)
  end

  def self.quotes_by_word(word, state)
    params = { query: {apikey: KEY,
                       phrase: word,
                       speaker_state: state,
                       start_date: "2015-01-01",
                       per_page: "1500"}}

    self.get("/text.json", params).parsed_response["results"].map(&:symbolize_keys)
  end
end

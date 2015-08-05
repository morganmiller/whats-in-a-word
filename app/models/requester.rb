class Requester
  include HTTParty
  base_uri 'http://capitolwords.org/api/1'
  KEY = ENV['sunlight_key']

  def self.most_used_words_for_state(state)
    params = { query: {apikey: KEY, entity_type: "state", entity_value: state}}
    self.get("/phrases.json", params).to_a
  end

  def self.quotes_by_word(word, state)
    params = { query: {apikey: KEY, phrase: word, speaker_state: state}}
    self.get("/text.json", params).to_a
  end
end

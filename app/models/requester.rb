class Requester
  #A PORO to assist with API requests
  include HTTParty
  base_uri 'http://capitolwords.org/api/1'
  KEY = ENV['sunlight_key']

  def self.most_used_phrases_for_state(state)
    params = { query: {apikey: KEY, entity_type: "state", entity_value: state}}
    binding.pry
    self.get("/phrases.json", params)
  end
end

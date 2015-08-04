class Requester
  #A PORO to assist with API requests
  include HTTParty
  base_uri 'http://capitolwords.org/api/1'
  KEY = ENV['sunlight_key']

  def self.most_used_phrases_for_state(state)
    params = { query: {apikey: KEY, entity_type: "state", entity_value: state}}
    self.get("/phrases.json", params)
  end


  #schedule rake tasks for this - once/day, once/5 mins, etc.

  #rake task for populating database with words and records


  #state table - has many words
  #words table - belongs to state, has many quotes
  #quotes table - belongs to word
    #with sentiment analysis attached to it
  #Do word cloud second to last - fill with most common words
  #Do twitter last
  #Do twitter oauth - with share functionality
end

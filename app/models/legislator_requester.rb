class LegislatorRequester
  include HTTParty
  base_uri 'https://congress.api.sunlightfoundation.com/'
  KEY = ENV['sunlight_key']

  def self.legislators_by_state(state)
    params = { query: {apikey: KEY,
      state: state.name,
      per_page: "50"}}

    self.get("/legislators?", params).parsed_response["results"]
  end

  def self.legislator_attrs(state)
    legislators_by_state(state).map do |legislator|
      { first_name: legislator["first_name"],
        last_name: legislator["last_name"],
        party: legislator["party"],
        phone: legislator["phone"],
        state_id: state.id,
        term_start: legislator["term_start"],
        term_end: legislator["term_end"],
        twitter_handle: legislator["twitter_id"],
        title: legislator["title"],
        website: legislator["website"]
      }
    end
  end
end

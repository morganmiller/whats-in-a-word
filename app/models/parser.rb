class Parser
  #A PORO to parse the data I pull in from API

  def most_used_phrases_for_state(state)
    Requester.most_used_phrases_for_state(state)
  end
end

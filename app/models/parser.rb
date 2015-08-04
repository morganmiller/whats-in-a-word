class Parser
  #A PORO to parse the data I pull in from API

  def self.most_used_phrases_for_state(state)
    words = Requester.most_used_phrases_for_state(state).to_a
    word_counts(words).sort
  end

  def self.word_counts(words)
    words.each_with_object([]) do |word, word_counts|
      word_counts << [word['count'], word["ngram"]]
    end
  end
end

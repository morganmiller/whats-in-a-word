class Parser
  def self.create_words
    state = State.find_by(name: "CO")
    # State.all.each do |state|
    Requester.word_attrs(state).each do |word|
      Word.find_or_create_by(word)
    end
    # end
  end

  def self.create_quotes
    Word.all.each do |word|
      Requester.quote_attrs(word.word, word.state).each do |quote|
        Quote.find_or_create_by(quote)
      end
    end
  end
end

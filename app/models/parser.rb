class Parser
  def self.create_words
    state = State.find_by(name: "CO")
    # State.all.each do |state|
    Word.find_or_create_by(Parser.word_attrs(state))
    # end
  end

  def self.create_quotes
    Word.all.each do |word|
      Quote.find_or_create_by(Parser.quote_attrs(word, word.state))
    end
  end
end

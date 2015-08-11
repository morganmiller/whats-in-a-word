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
        if quote[:body].length > 160
          Quote.find_or_create_by(quote)
        end
      end
    end
  end

  def self.create_legislators
    # State.all.each do |state|
      LegislatorRequester.legislator_attrs(State.find(7)).each do |person|
        Legislator.find_or_create_by(person)
      end
    # end
  end

  def self.create_leg_words
    Legislator.all.each do |leg|
      unless leg.bio_id.nil?
        Requester.leg_word_attrs(leg).each do |word|
          Word.find_or_create_by(word)
        end
      end
    end
  end

  def self.create_leg_quotes
    Legislator.all.each do |leg|
      leg.words.each do |word|
        unless leg.bio_id.nil?
          Requester.leg_quote_attrs(word, leg).each do |quote|
            if quote[:body].length > 160
              quote = Quote.find_or_create_by(quote)
              quote.update_attributes(legislator: leg)
            end
          end
        end
      end
    end
  end
end

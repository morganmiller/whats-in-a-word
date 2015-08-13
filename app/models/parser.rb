class Parser
  def self.create_leg_words
    Legislator.all.each do |leg|
      Requester.leg_word_attrs(leg).each do |word|
        Word.find_or_create_by(word)
      end
    end
  end

  def self.create_leg_quotes
    Legislator.all[4..-1].each do |leg|
      leg.words.each do |word|
        Requester.leg_quote_attrs(word, leg).each do |quote|
          if quote[:body].length > 160
            quote = Quote.find_or_create_by(quote)
            quote.update_attributes(legislator: leg)
          end
        end
      end
    end
    check_for_bad_words
  end

  def self.check_for_bad_words
    Word.all.each do |word|
      word.destroy! if word.quotes.count == 0
    end
  end
end

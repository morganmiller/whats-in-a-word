namespace :cw do
  desc "imports state words from capitol words API"
  task words: :environment do
    # State.all.each do |state|
    state = State.find_by(name: "CO")
      Requester.most_used_words_for_state(state).each do |word_stats|
        word = Word.find_or_create_by(word: word_stats["ngram"], mentions: word_stats["count"])
        state.words << word
      end
    # end
  end

  desc "imports quotes attached to specific words from capitol words API"
  task quotes: :environment do
    Sentimental.load_defaults
    State.find_by(name:"CO").words.each do |word|
      Requester.quotes_by_word(word.word, word.state.name).each do |quote_attrs|
        body = quote_attrs[:speaking].first
        if body.split.length > 20
          Quote.find_or_create_by(
            word: word,
            body: body,
            speaker: "#{quote_attrs[:speaker_first]} #{quote_attrs[:speaker_last]}",
            sentiment: Sentimental.new.get_score(body)
          )
        end
      end
    end
  end
end

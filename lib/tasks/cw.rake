namespace :cw do
  desc "imports state words from capitol words API"
  task words: :environment do
    State.all.each do |state|
      Requester.most_used_words_for_state(state.name).each do |word_stats|
        word = Word.find_or_create_by(word: word_stats["ngram"], mentions: word_stats["count"])
        state.words << word
      end
    end
  end

  desc "imports quotes attached to specific words from capitol words API"
  task quotes: :environment do
    State.find_by(name:"CO").words.each do |word|
      Requester.quotes_by_word(word.word, word.state.name)[1][1].each do |quotes|
        if quotes["speaking"].flatten.join(" ").split(" ").length > 10
          quote = Quote.find_or_create_by(body: quotes["speaking"].join(" "),
                                          speaker: "#{quotes["speaker_first"]} #{quotes["speaker_last"]}")
          word.quotes << quote
        end
      end
    end
  end
end

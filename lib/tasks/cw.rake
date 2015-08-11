namespace :cw do
  desc "imports state words from capitol words API"
  task words: :environment do
    Parser.create_words
  end

  desc "imports quotes attached to specific words from capitol words API"
  task quotes: :environment do
    Parser.create_quotes
  end

  desc "imports words attached to specific legislators"
  task leg_words: :environment do
    Parser.create_leg_words
  end

  desc "imports quotes attached to specific legislators"
  task leg_quotes: :environment do
    Parser.create_leg_quotes
  end
end

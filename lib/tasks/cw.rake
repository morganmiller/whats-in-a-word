namespace :cw do
  desc "imports state words from capitol words API"
  task words: :environment do
    Parser.create_words
  end

  desc "imports quotes attached to specific words from capitol words API"
  task quotes: :environment do
    Parser.create_quotes
  end
end

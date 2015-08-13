namespace :cw do
  desc "imports words attached to specific legislators"
  task leg_words: :environment do
    Parser.create_leg_words
  end

  desc "imports quotes attached to specific legislators"
  task leg_quotes: :environment do
    Parser.create_leg_quotes
  end

  desc "remove quoteless words"
  task quoteless_words: :environment do
    Parser.check_for_quoteless_words
  end
end

namespace :leg do
  desc "imports state legislators"
  task legislators: :environment do
    Parser.create_legislators
  end
end

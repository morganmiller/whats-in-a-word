json.array! Word.all do |word|
  json.text   word.word
  json.weight word.mentions
end

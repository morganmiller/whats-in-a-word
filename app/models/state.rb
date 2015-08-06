class State < ActiveRecord::Base
  has_many :words
  has_many :quotes, through: :words

  def cloud
    json.array! self.words.all do |word|
      json.text   word.word
      json.weight word.mentions
    end
  end
end

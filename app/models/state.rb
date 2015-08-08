class State < ActiveRecord::Base
  has_many :words
  has_many :quotes, through: :words

  def cloud
    self.words.map do |word|
      {text: word.word, weight: word.mentions}
    end
  end
end

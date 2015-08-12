class State < ActiveRecord::Base
  has_many :words
  has_many :quotes, through: :words
  has_many :legislators

  def cloud
    top_word_objects.map do |word|
      { text: word.word,
        weight: word.mentions,
        link: {href: "#", class: "cloud-link"}
      }
    end
  end

  def top_words
    words.order(mentions: :desc).pluck(:word).uniq
  end

  def top_word_objects
    top_words.map { |w| Word.find_by(word: w) }.first(30)
  end

  def to_param
    name
  end
end

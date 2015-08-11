class State < ActiveRecord::Base
  has_many :words
  has_many :quotes, through: :words
  has_many :legislators

  def cloud
    self.words.map do |word|
      { text: word.word,
        weight: word.mentions,
        link: {href: "#", class: "cloud-link"}
      }
    end
  end

  def to_param
    name
  end
end

class Legislator < ActiveRecord::Base
  belongs_to :state
  has_many :quotes
  has_many :words

  before_validation :set_bio_id

  def cloud
    self.words.map do |word|
      { text: word.word,
        weight: word.mentions,
        link: {href: "#", class: "cloud-link"}
      }
    end
  end

  def random_quotes
    self.quotes.sample(3)
  end

  def set_bio_id
    quotes = Quote.where(speaker: "#{first_name} #{last_name}")
    unless quotes == []
      self.bio_id = quotes.first.bio_id
    end
  end

  def show_party
    if party == "D"
      "Democrat"
    else
      "Republican"
    end
  end

  def show_title
    if title == "Rep"
      "Representative"
    else
      "Senator"
    end
  end
end

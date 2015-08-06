class Word < ActiveRecord::Base
  belongs_to :state
  has_many :quotes

  def congress_sentiments
    self.quotes.pluck(:sentiment)
  end

  def percent_positive
    (congress_sentiments.count { |n| n > 0 }.to_f / congress_sentiments.length.to_f * 100).to_i
  end

  def percent_negative
    (congress_sentiments.count { |n| n < 0 }.to_f / congress_sentiments.length.to_f * 100).to_i
  end

  def random_quotes
    self.quotes.sample(3)
  end
end

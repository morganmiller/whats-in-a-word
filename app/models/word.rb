class Word < ActiveRecord::Base
  belongs_to :state
  has_many :quotes
  belongs_to :legislator

  def congress_sentiments
    self.quotes.pluck(:sentiment)
  end

  def percent_positive
    unless congress_sentiments == []
      calculate_sentiment(:>)
    end
  end

  def percent_negative
    unless congress_sentiments == []
      calculate_sentiment(:<)
    end
  end

  def calculate_sentiment(operator)
    (congress_sentiments.count { |n| n.send(operator, 0) }.to_f / congress_sentiments.length.to_f * 100).to_i
  end

  def random_quotes
    self.quotes.sample(3)
  end
end

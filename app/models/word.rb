class Word < ActiveRecord::Base
  belongs_to :state
  has_many :quotes

  def congress_sentiment
    self.quotes.pluck
  end
end

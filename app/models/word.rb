class Word < ActiveRecord::Base
  belongs_to :state
  has_many :quotes
end

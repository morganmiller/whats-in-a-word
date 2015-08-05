class Quote < ActiveRecord::Base
  belongs_to :word
  validates :speaker, presence: true
end

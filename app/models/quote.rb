class Quote < ActiveRecord::Base
  belongs_to :word
  validates :speaker, presence: true
  validates :body, uniqueness: true
end

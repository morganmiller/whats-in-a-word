class State < ActiveRecord::Base
  has_many :words
  has_many :quotes, through: :words
end

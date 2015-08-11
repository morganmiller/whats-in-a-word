require 'test_helper'

class TweetFinderTest < ActiveSupport::TestCase
  test "it finds tweets by mentions of word" do
    t = TweetFinder.new
    feedback = t.filter_for("debt")
  end
end

require 'test_helper'

class RequesterTest < ActiveSupport::TestCase

  test "it makes a request to find common phrases by state" do
    Requester.most_used_phrases_for_state("CO")
  end
end

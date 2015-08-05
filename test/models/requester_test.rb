require 'test_helper'

class RequesterTest < ActiveSupport::TestCase
#Does this need to inherit from Active Support if it is a PORO? Probs not
  test "it makes a request to find common phrases by state" do
    Requester.most_used_words_for_state("CO")
  end
end

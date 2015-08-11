require 'test_helper'

class LegislatorRequesterTest < ActiveSupport::TestCase
  test "it finds legislators by state" do
    state = State.create(name: "CO")
    LegislatorRequester.legislator_attrs(state)
  end
end

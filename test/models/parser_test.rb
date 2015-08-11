require 'test_helper'

class ParserTest < ActiveSupport::TestCase

  test "it parses state words and sorts them by count" do
    skip
    state        = State.create(name: "CO", full_name: "Colorado")
    custom_attrs = [{ word: "government",
                      mentions: 500,
                      state: state
    }]


    assert_equal "government", Word.last.word
  end
end

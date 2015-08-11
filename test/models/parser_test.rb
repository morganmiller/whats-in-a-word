require 'test_helper'

class ParserTest < ActiveSupport::TestCase

  test "it parses state words and sorts them by count" do
    skip
    state        = State.create(name: "CO", full_name: "Colorado")
    custom_attrs = [{ word: "government",
                      mentions: 500,
                      state: state
    }]

    Requester.any_instance.stub(:word_attrs).with(custom_attrs)
    Parser.create_words
    assert_equal "government", Word.last.word
  end
end

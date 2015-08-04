require 'test_helper'

class ParserTest < ActiveSupport::TestCase

  test "it parses state words and sorts them by count" do
    Parser.most_used_phrases_for_state("CO")
  end
end

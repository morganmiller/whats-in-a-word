require 'test_helper'

class QuoteTest < ActiveSupport::TestCase
  test "it makes a cloud" do
    leg = Legislator.create(first_name: "Mark",
                            last_name: "Kirk")

    w  = Word.create(word: "bunny", legislator: leg, mentions: 2)
    w2 = Word.create(word: "donkey", legislator: leg, mentions: 3)
    w3 = Word.create(word: "elephant", legislator: leg, mentions: 1)

    expected = [
      {:text=>"bunny", :weight=>2, :link=>{:href=>"#", :class=>"cloud-link"}},
      {:text=>"donkey", :weight=>3, :link=>{:href=>"#", :class=>"cloud-link"}},
      {:text=>"elephant", :weight=>1, :link=>{:href=>"#", :class=>"cloud-link"}}
    ]

    assert_equal expected, leg.cloud
  end

  test "it shows party name" do
    leg = Legislator.create(first_name: "Mark",
                            last_name: "Kirk",
                            party: "D")
    assert_equal "Democrat", leg.show_party
  end

  test "it shows title" do
    leg = Legislator.create(first_name: "Mark",
                            last_name: "Kirk",
                            title: "S")

    assert_equal "Senator", leg.show_title
  end
end

require 'test_helper'

class StateTest < ActiveSupport::TestCase
  test "it makes a cloud" do
    co = State.create(name:"CO")
    w  = Word.create(word: "mountains", state: co, mentions: 2)
    w2 = Word.create(word: "rivers", state: co, mentions: 3)
    w3 = Word.create(word: "grizzlies", state: co, mentions: 1)

    expected = [
      {:text=>"rivers", :weight=>3, :link=>{:href=>"#", :class=>"cloud-link"}},
      {:text=>"mountains", :weight=>2, :link=>{:href=>"#", :class=>"cloud-link"}},
      {:text=>"grizzlies", :weight=>1, :link=>{:href=>"#", :class=>"cloud-link"}}
    ]

    assert_equal expected, co.cloud
  end

  test "it knows its params" do
    co = State.create(name: "CO")

    assert_equal "CO", co.to_param
  end
end

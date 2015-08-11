class TweetFinder
  attr_reader :client

  def initialize
    @client = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = "KLWGUyPEB8mtnagHRhNQa4RSe"
      config.consumer_secret     = "E2r5rMBebfnoo7nGE61kkAvXEojGce2rHAAxUskTORGR2cK84M"
      config.access_token        = "2841161697-LlMfT85Vm4gNKw9AXkzQEATYCZpD3j5zIShnJ3H"
      config.access_token_secret = "FM8NwvvbkD3y3DrTnrHeVbz7sYSalAVnXgzwvDslYCuRJ"
    end
  end

  def filter_for(word)
    binding.pry
    client.filter(:track => word) do |object|
      puts object.text if object.is_a?(Twitter::Tweet)
    end
  end
end

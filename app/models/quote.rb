class Quote < ActiveRecord::Base
  belongs_to :word
  belongs_to :legislator

  validates :speaker, presence: true
  validates :body, uniqueness: true

  def snippet
    all_words = body.delete("^a-zA-Z ").downcase.split
    return body if all_words.count <= 20

    i = all_words.index(word.word)

    #fix with validation?
    return "quote" if i.nil?
    ###

    start_i = i - 10
    end_i = i + 10

    all_words = body.split
    if start_i >= 0 && end_i <= (all_words.count - 1)
      "...#{all_words[start_i..end_i].join(" ")}..."
    elsif !(start_i >= 0)
      "#{all_words[0..end_i].join(" ")}..."
    elsif !(end_i <= (all_words.count - 1))
      "...#{all_words[start_i..-1].join(" ")}"
    end
  end
end

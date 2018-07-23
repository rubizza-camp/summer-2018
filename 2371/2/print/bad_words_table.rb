require_relative 'table'
require_relative 'bad_word_row'
# The BadWordsTable responsible for printing Authors bad words stat
class BadWordsTable < Table
  def initialize(authors)
    @authors = authors
  end

  def rows
    @authors.sort_by { |author| -author.bad_words.size }.map do |author|
      BadWordRow.new(author).to_a
    end
  end
end

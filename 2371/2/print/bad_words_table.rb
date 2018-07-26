require_relative 'table'
require_relative 'bad_word_row'
# The BadWordsTable responsible for printing Authors bad words stat
class BadWordsTable < Table
  def initialize(authors)
    @authors = authors
  end

  def rows
    data = @authors.map do |author|
      BadWordRow.new(author).to_a
    end
    data.any? ? data : [[NO_AUTHORS]]
  end
end

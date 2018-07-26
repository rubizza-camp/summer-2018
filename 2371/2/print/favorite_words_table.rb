require_relative 'table'
# The FavoriteWordsTable responsible for printing Authors favorite words stat
class FavoriteWordsTable < Table
  def initialize(authors)
    @authors = authors
  end

  def rows
    puts 'in progress'
  end
end

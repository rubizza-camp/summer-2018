require './author'
require './battle'
require './reader'

# This class read rappers name
class AuthorReader < Reader
  private

  def battles_stats_array(array)
    new_author = Author.new(array[:name])
    result << new_author
    battles = array[:text].map { |text| Battle.new(text) }
    result.last.add_battles(battles)
  end
end

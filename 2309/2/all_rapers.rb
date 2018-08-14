require 'pry'
require_relative 'parse_string.rb'

# Class all rapers, collection of statistics
class AllRapers
  attr_reader :all_rapers
  def initialize
    @all_rapers = {}
  end

  LIST_ALL_BATTLES = Dir['rap-battles/*']

  def create_all_rapers
    LIST_ALL_BATTLES.each do |file|
      search = SearchBattles.new(name = ParseString.new.search_name(file))
      search.count_battles
      raper = Raper.new(name, search.list)
      @all_rapers[name] = raper unless @all_rapers.key? name
    end
  end

  def sorting(limit)
    @all_rapers.values.sort_by { |raper| - raper.bad_words }.first(limit)
  end
end

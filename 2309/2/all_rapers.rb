require 'pry'
require_relative 'raper.rb'
require_relative 'parse_string.rb'
require_relative 'search_battles.rb'

# Class all rapers, collection of statistics
class AllRapers
  attr_reader :all_rapers
  def initialize
    @all_rapers = {}
    create_all_rapers
  end

  LIST_ALL_BATTLES = Dir['rap-battles/*']

  def create_all_rapers
    LIST_ALL_BATTLES.each do |file|
      list_battles(name_raper(file))
      raper(@name_raper, @list_battles)
      @all_rapers[@name_raper] = @raper unless @all_rapers.key? @name_raper
    end
  end

  def name_raper(title_battle)
    @name_raper = ParseString.new.search_name(title_battle)
  end

  def list_battles(name)
    @list_battles = SearchBattles.new(name).list
  end

  def raper(name, list)
    @raper = Raper.new(name, list)
  end
end

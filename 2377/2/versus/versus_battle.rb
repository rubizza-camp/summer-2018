require_relative 'battle'
require_relative 'rapper'

# Class collects data about battles and rappers
class VersusBattle
  attr_reader :rappers
  def initialize
    @rappers = []
    @files = Dir.glob('*[^.rb]')
    @exp = /((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/
  end

  def create_rapper_array
    @files.each do |filename|
      add_rappers(filename)
    end
  end

  def create_battle_array
    @files.each do |filename|
      battles_for_rappers(filename)
    end
  end

  def sort_rappers
    @rappers = @rappers.sort_by { |rpr| -rpr.bad_words }
  end

  def add_rappers(filename)
    rapper_exists_cause(filename) unless rapper_check(filename)
  end

  def rapper_check(filename)
    @rappers.any? { |raper| raper.name == filename[@exp] }
  end

  def rapper_exists_cause(filename)
    rpr = Rapper.new(filename)
    @rappers.push(rpr)
  end

  def battles_for_rappers(filename)
    current ||= @rappers.find { |raper| raper.name == filename[@exp] }
    btl = Battle.new(filename)
    current.battles.push(btl)
  end

  def find_favourite_words(rapper)
    analyze = WordAnalyzer.new(rapper)
    analyze.find_favourite_words
  end
end

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
      uniq_rappers(filename)
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

  def uniq_rappers(filename)
    unless @rappers.any? { |raper| raper.name == filename[@exp] }
      rpr = Rapper.new(filename)
      @rappers.push(rpr)
    end
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

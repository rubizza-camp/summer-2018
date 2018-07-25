require_relative 'battle'
require_relative 'rapper'

# Class collects data about battles and rappers
class VersusBattle
  attr_reader :rappers
  EXP = /((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/
  def initialize
    @rappers = []
    @files = Dir.glob('*[^.rb]')
    @hash = {}
  end

  def create_rapper_array
    @files.each do |filename|
      next if rapper_check(filename)
      rapper = Rapper.new(filename)
      @hash[rapper.name] = rapper
      @rappers << rapper
    end
  end

  def create_battle_array
    @files.each do |filename|
      battles_for_rappers(filename)
    end
  end

  def sort_rappers
    @rappers.sort_by { |rpr| -rpr.bad_words }
  end

  private

  def add_rappers(filename)
    rapper_exists?(filename) unless rapper_check(filename)
  end

  def rapper_check(filename)
    @hash.any? { |key, _value| key == filename[EXP] }
  end

  def rapper_exists?(filename)
    rapper = Rapper.new(filename)
    @rappers.push(rapper)
  end

  def battles_for_rappers(filename)
    current ||= @rappers.find { |raper| raper.name == filename[EXP] }
    current.battles.push(Battle.new(filename))
  end
end

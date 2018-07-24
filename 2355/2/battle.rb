# This class describes battle
class Battle
  attr_reader :file, :words_count

  def initialize(name, number)
    @name = name
    @file = File.new("./rap-battles/#{name}/#{number}")
    @words_count = File.readlines("./rap-battles/#{name}/#{number}").join.split.length
  end
end

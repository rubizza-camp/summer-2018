require_relative 'battle.rb'

# Class one raper
class Raper

  attr_reader :battles

  def initialize(namee)
    @name = namee
    @battles = []
    @all_words = 0
    @bad_words = 0
  end

  def read_spis_files
    Dir['rap-battles/*']
  end

  def count_battles
    read_spis_files.each do |file|
      file = file[13...file.size]
      file.index(@name) == 0 ? @battles.push(Battle.new(file)) : next
    end
  end
end

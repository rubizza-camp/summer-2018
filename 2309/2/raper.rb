require_relative 'battle.rb'

# Class one raper
class Raper

  attr_reader :battles, :all_words, :bad_words

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
      file.index(@name) == 13 ? @battles.push(Battle.new(file)) : next
    end
  end

  def count_all_words
    @battles.each do |battle|
      @all_words += battle.sum_all_words
    end
  end

  def count_bad_words
    @battles.each do |battle|
      @bad_words += battle.bad_words_count
    end
  end

end

a = Raper.new('Oxxxymiron')
a.count_battles
a.count_all_words
a.count_bad_words

puts a.battles.inspect

puts a.all_words.inspect

puts a.bad_words.inspect

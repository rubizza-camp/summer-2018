require_relative 'rapper_class'
require_relative 'printer_class'
require_relative 'word_analizer_class'
require_relative 'battles_class'
# Class keeps data about battles and rappers
class Versus
  attr_reader :rappers, :battles, :fav_words_array, :rounds
  def initialize
    @battles = []
    @rappers = []
    @fav_words_array = []
    @rounds = []
    @exp = /((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/
  end

  def create_rapper_array
    @battles.each do |battle|
      if @rappers.any? { |raper| raper.name == battle.filename[@exp] }
        condition_true(battle)
      else
        r = Rapper.new(battle.filename)
        r.count_bad_words(battle)
        @rappers.push(r)
      end
    end
  end

  def condition_true(battle)
    r = @rappers.find { |rapper| rapper.name == battle.filename[@exp] }
    r.count_bad_words(battle)
    r.battles += 1
  end

  def create_battle_array
    files = Dir.glob('*[^.rb]')
    files.each do |file|
      b = Battle.new(file)
      b.count_words_per_round
      @battles.push(b)
    end
  end

  def sort_rappers
    @rappers = @rappers.sort_by { |r| -r.bad_words }
    @rappers.each(&:count_words_per_battle)
  end

  def find_favourite_words
    @rappers.each do |rapper|
      bbb = @battles.find_all { |battle| battle.filename[@exp] == rapper.name }
      txt = WordAnalizer.new(rapper)
      bbb.each do |battle|
        txt.find_favourite_words(battle)
      end
      @fav_words_array.push(txt)
    end
  end

  def count_words_per_round
    @rappers.each do |rapper|
      bbb = @battles.find_all { |battle| battle.filename[@exp] == rapper.name }
      buf = 0
      bbb.each do |battle|
        buf += battle.words_per_round
      end
      @rounds << buf / rapper.battles
    end
  end
end

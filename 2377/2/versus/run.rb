require_relative 'rapper_class'
require_relative 'printer_class'
require_relative 'word_analizer_class'
require_relative 'battles_class'
# Class keeps data about battles and rappers
# :reek:TooManyInstanceVariables
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
      read_battle(battle)
    end
  end

  def read_battle(battle)
    if @rappers.any? { |raper| raper.name == battle.filename[@exp] }
      condition_true(battle)
    else
      condition_false(battle)
    end
  end

  def condition_false(battle)
    rpr = Rapper.new(battle.filename)
    rpr.count_bad_words(battle)
    @rappers.push(rpr)
  end

  def condition_true(battle)
    rpr = @rappers.find { |rapper| rapper.name == battle.filename[@exp] }
    rpr.count_bad_words(battle)
    rpr.battles += 1
  end

  def create_battle_array
    files = Dir.glob('*[^.rb]')
    files.each do |file|
      btl = Battle.new(file)
      btl.count_words_per_round
      @battles.push(btl)
    end
  end

  def sort_rappers
    @rappers = @rappers.sort_by { |rpr| -rpr.bad_words }
    @rappers.each(&:count_words_per_battle)
  end

  def find_favourite_words
    @rappers.each do |rapper|
      favourite_words_of_rapper(rapper)
    end
  end

  #:reek:TooManyStatements
  def favourite_words_of_rapper(rapper)
    bbb = @battles.find_all { |battle| battle.filename[@exp] == rapper.name }
    txt = WordAnalizer.new(rapper)
    bbb.each do |battle|
      txt.find_favourite_words(battle)
    end
    @fav_words_array.push(txt)
  end

  def count_words_per_round
    @rappers.each do |rapper|
      words_per_round(rapper)
    end
  end

  #:reek:TooManyStatements
  def words_per_round(rapper)
    bbb = @battles.find_all { |battle| battle.filename[@exp] == rapper.name }
    buf = 0
    bbb.each do |battle|
      buf += battle.words_per_round
    end
    @rounds << buf / rapper.battles
  end
end

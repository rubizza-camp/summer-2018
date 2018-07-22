require_relative 'battle'
require_relative 'word_analizer'
require 'russian_obscenity'
# This class keeps the information about rapper
class Rapper
  attr_reader :name, :battles
  def initialize(filename)
    @name = filename[/((\w|\d|.|\s)*?)(?=против|[vV][Ss] )/]
    @battles = []
  end

  def words_per_battle
    return words_per_battle = bad_words / @battles.size
  end

  def bad_words
    return bad_words ||= @battles.sum(&:count_bad_words)
  end

  def words_per_round
    return @battles.sum(&:count_words_per_round)
  end

  def fav_words
    anlz = WordAnalizer.new
    @battles.each do |battle|
      anlz.find_favourite_words(battle)
    end
    return anlz.fav_words
  end

  def create_row
    row = []
    row << name
    row << "#{@battles.size} battles"
    row << "#{bad_words} bad words"
    row << "#{words_per_battle} words per battle"
    row << "#{words_per_round} words per round"
    return row
  end
end

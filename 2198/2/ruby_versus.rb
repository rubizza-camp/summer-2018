require 'pry'
require 'russian_obscenity'
require 'terminal-table'

# Class for gathering data about battle
class Battle
  def initialize(filename)
    @filename = filename
  end

  def all_words_in_battle
    text.scan(/(?!\*\*\*)[\wа-яА-ЯёЁ*]+/).count
  end

  def bad_words_in_battle
    text.split(/\s|,/).select do |word|
      word_is_bad(word) &&
        word != '***'
    end.count
  end

  def rounds_in_battle
    rounds_in_battle = text.scan(/[Рр]аунд \d+/).count
    rounds_in_battle.zero? ? 1 : rounds_in_battle
  end

  private

  def text
    @text ||= File.read(@filename)
  end

  def word_is_bad(word)
    word.include?('*') || RussianObscenity.obscene?(word)
  end
end

# Class for gathering data about rapper
class Rapper
  def initialize(name)
    @name = name
    all_files = Dir.glob('rap-battles/*')
    texts = all_files.select { |file| file.start_with?("rap-battles/ #{name}") }
    @battles = texts.map { |file| Battle.new(file) }
  end

  def count_battles
    @battles.count
  end

  def bad_words_in_battles
    @battles.sum(&:bad_words_in_battle)
  end

  def bad_words_per_battle
    bad_words_in_battles / count_battles.to_f
  end

  def all_words_in_battles
    @battles.sum(&:all_words_in_battle)
  end

  def rounds_in_battles
    @battles.sum(&:rounds_in_battle)
  end

  def words_per_round
    all_words_in_battles / rounds_in_battles.to_f
  end
end

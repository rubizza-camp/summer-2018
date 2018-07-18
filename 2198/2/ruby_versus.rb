require 'pry'
require 'russian_obscenity'
require 'terminal-table'

param_name, param_value = ARGF.argv[0].split('=')
if param_name == '--top-bad-words'
  top_bad_words = param_value.to_i
else
  puts 'invalid param'
  return
end

# Class for gathering data about battle
class Battle
  def initialize(filename)
    @filename = filename
  end

  # counts quantity of all words in the battle
  def count_all_words_in_battle
    text.scan(/(?!\*\*\*)[а-яА-ЯёЁ*]+/).count
  end

  # counts quantity of bad words in the battle
  def count_bad_words_in_battle
    text.split(/\s|,/).select { |word| word_is_bad(word) && word != '***' }.count
  end

  # counts quantity of rounds in the battle
  def count_rounds_in_battle
    rounds_in_battle = text.scan(/[Рр]аунд \d+/).count
    rounds_in_battle.zero? ? 1 : rounds_in_battle
  end

  private

  # opens content of the file
  def text
    @text ||= File.read(@filename)
  end

  # checks if the word is bad
  def word_is_bad(word)
    word.include?('*') || RussianObscenity.obscene?(word)
  end
end

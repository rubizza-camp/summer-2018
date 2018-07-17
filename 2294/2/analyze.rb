require_relative './file_parser.rb'
require 'russian_obscenity'
require 'yaml'
RussianObscenity.dictionary = [:default, 'dictionary.yml']

# Analyze text of current artist
# :reek:UtilityFunction
class Analyze
  WORD_SETTING = YAML.safe_load(File.read('pluralize_settings.yml'))
  DEFAULT_BATTLES = 3
  attr_reader :name, :battles
  def initialize(key, value)
    @name = key
    @battles = value
  end

  def row
    [column_one, column_two, column_three, column_four, column_five]
  end

  private

  def text
    @battles.join(' ')
  end

  def words
    text.split(' ')
  end

  def battles_count
    @battles.size
  end

  def rounds
    battles_count * DEFAULT_BATTLES
  end

  def bad_count
    count = 0
    RussianObscenity.find(text).each do |bad|
      count += text.split(' ').count(bad)
    end
    count
  end

  def bad_words_per_battle
    bad_count / battles_count
  end

  def total_words_in_round
    words.size / rounds
  end

  def pluralize(count, words)
    return words[-1] if (10..20).cover? count
    type = count % 10
    return words[0] if type == 1
    return words[1] if (2..4).cover? type
    words.last
  end

  def column_one
    name
  end

  def column_two
    "#{battles_count} #{pluralize(battles_count, WORD_SETTING['three'])}"
  end

  def column_three
    "#{bad_count} #{pluralize(bad_count, WORD_SETTING['two'])} #{pluralize(bad_count, WORD_SETTING['one'])}"
  end

  def column_four
    "#{bad_words_per_battle.round(2)} на батл"
  end

  def column_five
    "#{total_words_in_round} #{pluralize(total_words_in_round, WORD_SETTING['one'])} в раунде"
  end
end

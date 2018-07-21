require_relative './pluralize.rb'
require 'russian_obscenity'
require 'yaml'
RussianObscenity.dictionary = [:default, 'dictionary.yml']

# Analyze text of current artist
class Analyze
  WORD_SET = YAML.safe_load(File.read('pluralize_settings.yml'))
  DEFAULT_BATTLES = 3
  attr_reader :name, :battles

  def initialize(key, value)
    @name = key
    @battles = value
  end

  def row
    [name_column, battles_column, bad_words_column, bad_words_per_battle_column, words_per_round_column]
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
    @rounds ||= battles_count * DEFAULT_BATTLES
  end

  def bad_count
    @bad_count ||= RussianObscenity.find(text).inject(0) do |count, bad|
      count + text.split(' ').count(bad)
    end
  end

  def bad_words_per_battle
    bad_count / battles_count
  end

  def total_words_in_round
    words.size / rounds
  end

  def name_column
    name
  end

  def battles_column
    "#{battles_count} #{Pluralize.change(battles_count, WORD_SET['battles'])}"
  end

  def bad_words_column
    "#{bad_count} #{Pluralize.change(bad_count, WORD_SET['bad'])} #{Pluralize.change(bad_count, WORD_SET['words'])}"
  end

  def bad_words_per_battle_column
    "#{bad_words_per_battle.round(2)} на батл"
  end

  def words_per_round_column
    "#{total_words_in_round} #{Pluralize.change(total_words_in_round, WORD_SET['words'])} в раунде"
  end
end

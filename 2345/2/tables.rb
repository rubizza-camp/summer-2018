require_relative 'hundler.rb'
require 'russian'

# This class contains the configuration of the table with the results.
class CreateTable
  attr_reader :top_rappers

  def initialize
    @top_rappers = top_rappers
    @rows = []
  end

  # :reek:DuplicateMethodCall
  # :reek:FeatureEnvy
  def rows_array(data)
    rapper = data[1]
    words_of_battle = WordsHundler.new.words_battle(data)
    words_of_round = WordsHundler.new.words_round(data)
    row = [
      data[0],
      "#{rapper.battle_count} #{WordsHundler.new.battle(rapper.battle_count)}",
      "#{rapper.bad_words} нецензурных слов",
      "#{words_of_battle} #{WordsHundler.new.slovo(words_of_battle)} на баттл",
      "#{words_of_round} #{WordsHundler.new.slovo(words_of_round)} в раунде"
    ]
    @rows.push(row)
  end

  HEADER = [
    'Participant',
    'Number of battles',
    'Swear words',
    'Swear words in battle',
    'Swear words in round'
  ].freeze

  def table(top_rappers)
    top_rappers.map { |data| rows_array(data) }
    @table_params = {
      headings: HEADER,
      rows: @rows,
      style: { alignment: :center, all_separators: true }
    }
  end
end

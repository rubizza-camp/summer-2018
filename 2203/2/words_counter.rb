require './battles_reader.rb'
require './modules/line_cleaner.rb'
require './modules/words_calculator.rb'

# Count all and bad words
class WordsCounter
  attr_reader :name, :battles_list, :bad_words_count, :all_words_count
  include LineCleaner
  include WordsCalculator

  def initialize(rapper_name)
    @name            = rapper_name
    @battles_list    = BattlesReader.new(name).battles_list
    @bad_words_count = bad_words_in_each_battle.values.sum
    @all_words_count = all_words_in_each_battle.values.sum
  end

  private

  def total_words
    @total_words ||= battles_list.each_with_object(Hash.new(0)) do |battle_file_path, hash_total_words|
      hash_total_words[battle_file_path] = LineCleaner.line_cleaner(battle_file_path)
    end
  end

  def bad_words_in_each_battle
    total_words.values.each_with_object(Hash.new(0)) do |battle, all_words_count|
      all_words_count[battle] += WordsCalculator.calculate_bad_words(battle)
    end
  end

  def all_words_in_each_battle
    total_words.values.each_with_object(Hash.new(0)) do |battle, all_words_count|
      all_words_count[battle] += WordsCalculator.calculate_all_words(battle)
    end
  end
end

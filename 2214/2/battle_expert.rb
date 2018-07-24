require 'terminal-table'
require_relative 'popular_words_counter'
require_relative 'battler'
require_relative 'battle'
require_relative 'battles_by_name_giver'

class BattleExpert
  include BattlesByNameGiver
  BATTLES_FOLDER = 'Battles'.freeze
  def describe_battlers(top_bad_words)
    puts Terminal::Table.new rows: sorted_battlers.first(top_bad_words).map(&:describe_yourself)
  end

  def find_popular_words(battler_name, top_words = 30)
    if battlers_names.include? battler_name
      PopularWordsCounter.new(battlers.find { |battler| battler.name.eql? battler_name }, top_words).count
    else
      puts "Я не знаю МЦ #{battler_name}. Зато мне известны:"
      battlers_names.each { |battler| puts battler }
    end
  end

  private

  def sorted_battlers
    @sorted_battlers ||= battlers.sort_by(&:bad_words_per_round).reverse
  end

  def battlers
    battlers_names.map { |battler_name| Battler.new(battler_name, BattlesByNameGiver.take(battles, battler_name)) }
  end

  def battlers_names
    Dir.chdir(BATTLES_FOLDER) { Dir.glob('*против*').map { |title| title.split('против').first.strip }.uniq }
  end

  def battles
    Dir.chdir(BATTLES_FOLDER) { Dir.glob('*против*').map { |title| Battle.new(title, File.read(title)) } }
  end
end

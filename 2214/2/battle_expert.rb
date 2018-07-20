require 'terminal-table'
require_relative 'popular_words_counter'
require_relative 'battler'
require_relative 'battle'

class BattleExpert
  BATTLES_FOLDER = 'Battles'.freeze
  def describe_battlers(top_bad_words)
    puts Terminal::Table.new rows: sorted_battlers[0...top_bad_words].map { |battler| battler_as_row(battler) }
  end

  def find_popular_words(battler_name, top_words = 30)
    if battlers_names.include? battler_name
      PopularWordsCounter.new(battles, battler_name, top_words).count
    else
      puts "Я не знаю МЦ #{battler_name}. Зато мне известны:"
      battlers_names.each { |battler| puts battler }
    end
  end

  private

  def sorted_battlers
    battlers.sort_by(&:bad_words_per_round).reverse
  end

  def battlers
    battlers_names.map { |battler_name| Battler.new(battler_name, battles) }
  end

  def battlers_names
    Dir.chdir(BATTLES_FOLDER) { Dir.glob('*против*').map { |title| title.split('против').first.strip }.uniq }
  end

  def battles
    Dir.chdir(BATTLES_FOLDER) { Dir.glob('*против*').map { |title| Battle.new(title, File.read(title)) } }
  end

  def battler_as_row(battler)
    [
      battler.name.to_s,
      "#{battler.number_of_battles} баттлов",
      "#{battler.number_of_bad_words} нецензурных слов",
      "#{battler.bad_words_per_round} слова на баттл",
      "#{battler.average_number_of_words} слов в раунде"
    ]
  end
end

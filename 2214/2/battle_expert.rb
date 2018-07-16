require 'commander'
require 'terminal-table'
require_relative 'bad_words_counter'
require_relative 'words_in_round_counter'
require_relative 'popular_words_counter'
require_relative 'battler'
require_relative 'battle'

class BattleExpert
  BATTLES_FOLDER = 'Battles'.freeze
  def initialize
    @battles = take_battles
    @battlers_names = find_all_battlers
  end

  def describe_battlers(top_bad_words)
    battlers = []
    @battlers_names.each { |battler_name| battlers << process_battler(battler_name) }
    battlers = sort_battlers(battlers)
    show_top_battlers(battlers, top_bad_words)
  end

  def find_popular_words(battler_name, top_words = 30)
    if @battlers_names.include? battler_name
      PopularWordsCounter.count(@battles, battler_name, top_words)
    else
      puts "Я не знаю МЦ #{battler_name}. Зато мне известны:"
      @battlers_names.each { |battler| puts battler }
    end
  end

  private

  def process_battler(battler_name)
    count_of_battles = count_battles(battler_name)
    bad_words = BadWordsCounter.count(@battles, battler_name)
    words_in_round = WordsInRoundCounter.count(@battles, battler_name, count_of_battles)
    average_number = (bad_words.to_f / count_of_battles).round(2)
    Battler.new(battler_name, count_of_battles, bad_words, average_number, words_in_round)
  end

  def count_battles(battler_name)
    count_of_battles = 0
    Dir.chdir(BATTLES_FOLDER) do
      Dir.glob("*#{battler_name}*").each do |title|
        count_of_battles += 1 if title.split('против').first.include? battler_name
      end
    end
    count_of_battles
  end

  def show_top_battlers(battlers, top_bad_words)
    rows = []
    top_bad_words.times do |ind|
      rows << get_battler_as_row(battlers[ind])
    end
    table = Terminal::Table.new rows: rows
    puts table
  end

  def sort_battlers(battlers)
    battlers.sort_by! { |battler| battler.parametres[2] }.reverse!
  end

  def get_battler_as_row(battler)
    [
      battler.name.to_s,
      "#{battler.parametres[0]} баттлов",
      "#{battler.parametres[1]} нецензурных слов",
      "#{battler.parametres[2]} слова на баттл",
      "#{battler.parametres[3]} слов в раунде"
    ]
  end

  def find_all_battlers
    battlers = []
    Dir.chdir(BATTLES_FOLDER) do
      Dir.glob('*против*').each do |title|
        battlers << title.split('против').first.strip
      end
    end
    battlers.uniq
  end

  def take_battles
    battles = []
    Dir.chdir(BATTLES_FOLDER) do
      Dir.glob('*против*').each do |title|
        battles << Battle.new(title, File.read(title))
      end
    end
    battles
  end
end

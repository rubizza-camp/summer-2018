require 'commander'
require 'terminal-table'
require_relative 'bad_words_counter'
require_relative 'words_in_round_counter'
require_relative 'popular_words_counter'
require_relative 'battler'

class BattleExpert
  BATTLES_FOLDER = 'Battles'.freeze
  def describe_battlers(top_bad_words)
    battlers = []
    find_all_battlers.each { |battler_name| battlers << process_battler(battler_name) }
    battlers = sort_battlers(battlers)
    show_top_battlers(battlers, top_bad_words)
  end

  def find_popular_words(name, top_words = 30)
    if find_all_battlers.include? name
      battles_titles = take_battles_titles(name)
      PopularWordsCounter.count(battles_titles, top_words)
    else
      puts "Я не знаю МЦ #{name}. Зато мне известны:"
      find_all_battlers.each { |battler| puts battler }
    end
  end

  private

  def process_battler(battler)
    battles_titles = take_battles_titles(battler)
    bad_words = BadWordsCounter.count(take_battles_titles(battler))
    words_in_round = WordsInRoundCounter.count(take_battles_titles(battler))
    average_number = (bad_words.to_f / battles_titles.size).round(2)
    Battler.new(battler, battles_titles.size, bad_words, average_number, words_in_round)
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

  def take_battles_titles(battler)
    battles_titles = []
    Dir.chdir(BATTLES_FOLDER) do
      Dir.glob("*#{battler}*").each do |title|
        battles_titles << title if title.split('против').first.include? battler
      end
    end
    battles_titles
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
    row = []
    row += [battler.name.to_s, "#{battler.parametres[0]} баттлов", "#{battler.parametres[1]} нецензурных слов"]
    row += ["#{battler.parametres[2]} слова на баттл", "#{battler.parametres[3]} слов в раунде"]
    row
  end
end

require 'commander'
require 'terminal-table'
require 'russian_obscenity'
require 'optparse'

INPUT_FOLDER = 'rap-battles'.freeze

class Battler
  attr_reader :name, :data
  def initialize(name, battles_count, bad_words_count, bad_in_round, words_in_round)
    @name = name
    @data = [battles_count, bad_words_count, bad_in_round, words_in_round]
  end
end

class BadWordsCounter
  def self.count(battles)
    total_bad_words = 0
    battles.each do |battle|
      total_bad_words += count_bad_words(Dir.chdir(INPUT_FOLDER) { File.read(battle) })
    end
    total_bad_words
  end

  def self.count_bad_words(file)
    local_bad_words = 0
    file.split.each do |word|
      local_bad_words += 1 if RussianObscenity.obscene?(word)
    end
    local_bad_words += file.count('*')
    local_bad_words
  end
end

class TotalWordsInRoundCounter
  def self.count(battles)
    words = 0
    battles.each do |battle|
      words += Dir.chdir(INPUT_FOLDER) { File.read(battle) }.gsub(/[.!-?,:]/, ' ').strip.split.count
    end
    words / (battles.size * 3)
  end
end

class BattleCheck
  def describe_battlers(top_bad_words)
    battlers = []
    find_all_battlers.each { |battler_name| battlers << process_battler(battler_name) }
    battlers = battlers.sort_by! { |battler| battler.data[1] }.reverse!
    display_top_battlers(battlers, top_bad_words)
  end

  private

  # :reek:UtilityFunction
  def find_all_battlers
    battlers = []
    Dir.chdir(INPUT_FOLDER) do
      Dir.glob('*против*').each do |title|
        battlers << title.split('против').first.strip
      end
    end
    battlers.uniq
  end

  # :reek:TooManyStatements
  # :reek:DuplicateMethodCall
  def process_battler(battler)
    battles_titles = take_battles_titles(battler)
    total_bad_words = BadWordsCounter.count(take_battles_titles(battler))
    words_in_round = TotalWordsInRoundCounter.count(take_battles_titles(battler))
    average_bad_words_number = avg_number(total_bad_words, battles_titles)
    Battler.new(battler, battles_titles.size, total_bad_words, average_bad_words_number, words_in_round)
  end

  # :reek:UtilityFunction
  def avg_number(total_bad_words, battles_titles)
    (total_bad_words.to_f / battles_titles.size).round(2)
  end

  # :reek:UtilityFunction
  def take_battles_titles(battler)
    battles_titles = []
    Dir.chdir(INPUT_FOLDER) do
      Dir.glob("*#{battler}*").each do |title|
        battles_titles << title if title.split('против').first.include? battler
      end
    end
    battles_titles
  end

  def display_top_battlers(battlers, top_bad_words)
    rows = []
    top_bad_words.times do |ind|
      rows << get_battler_as_row(battlers[ind])
    end
    table = Terminal::Table.new rows: rows
    puts table
  end

  # rubocop:disable Metrics/LineLength
  # :reek:DuplicateMethodCall
  # :reek:UtilityFunction
  def get_battler_as_row(battler)
    row = []
    row += [battler.name.to_s, "#{battler.data[0]} баттлов", "#{battler.data[1]} нецензурных слов", "#{battler.data[2]} слова на баттл", "#{battler.data[3]} слов в раунде"]
    row
  end
end

battlers_table = BattleCheck.new

OptionParser.new do |parser|
  parser.banner = 'Usage: ruby versus_check.rb [options]'
  parser.on('--top-bad-words=', "View number of battlers, sorted by battler's total number of bad words") do |top_bad_words|
    battlers_table.describe_battlers(top_bad_words.to_i)
  end
end.parse!
# rubocop:enable Metrics/LineLength

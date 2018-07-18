require 'pry'
require 'russian_obscenity'
require 'terminal-table'
require 'optparse'
# Class for Battle
class Battle
  def initialize(file_name)
    @file_name = file_name
  end

  def count_bad_words
    fetch_words.count do |word|
      word.include?('*') || RussianObscenity.obscene?(word)
    end
  end

  def words_count
    fetch_words.count
  end

  def count_all_words
    fetch_words.count
  end

  def rounds_count
    rounds_number = fetch_text.scan(/Раунд \d/).length
    rounds_number.equal?(0) ? 1 : rounds_number
  end

  private

  def fetch_text
    @fetch_text ||= File.read(@file_name)
  end

  def fetch_words
    @all_words = fetch_text.scan(/[а-яА-ЯёЁ*]+/)
  end
end
# Class for Artist - Battle belongs_to Artist?:)
class Artist
  attr_reader :battler_name
  def initialize(battler_name)
    @battler_name = battler_name
    @battlers_array = []
  end

  def add_battles(file_name)
    @battlers_array << Battle.new(file_name)
  end

  def create_table_row
    [
      @battler_name,
      battles_number.to_s + ' батлов',
      count_bad_words.to_s + ' нецензурных слов',
      bad_words_in_battle.round(2).to_s + ' слов на батл',
      words_in_round.round(2).to_s + ' слов в рануде'
    ]
  end

  def count_bad_words
    @count_bad_words ||= @battlers_array.sum(&:count_bad_words)
  end

  private

  def bad_words_in_battle
    count_bad_words.to_f / battles_number
  end

  def words_count
    @battlers_array.sum(&:words_count)
  end

  def rounds_count
    @battlers_array.sum(&:rounds_count)
  end

  def battles_number
    @battlers_array.size
  end

  def words_in_round
    (words_count / rounds_count.to_f).to_f
  end
end
# Class for working with Battles and Artist class
class Handler
  attr_reader :rappers
  def initialize
    @rappers = battlers
  end

  def sort_top_rappers(number)
    rappers.values.sort_by { |item| - item.count_bad_words }.first(number)
  end

  private

  def battlers
    Dir.glob('./battles2/*').each_with_object({}) do |file_name, rappers|
      next unless File.file?(file_name)
      rapper_name = find_artist_by_name(file_name)
      rappers[rapper_name] ||= Artist.new(rapper_name)
      rappers[rapper_name].add_battles(file_name)
    end
  end

  def find_artist_by_name(file_name)
    rappers.class.equal?(Hash)
    file_name.split(/#|против|vs|VS|aka/)\
             .first.split('/').last.strip
  end
end

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    number_rappers = Handler.new.sort_top_rappers(top_bad_words.to_i)
    system('clear')
    puts Terminal::Table.new(rows: number_rappers.map(&:create_table_row))
  end
  parser.on('--help') do
    puts 'add --help to watch this text))'
    puts 'add --top-bad-words=<number> to ruby \
    (your_file) to show <number> the most abusive artists!'
  end
end.parse!

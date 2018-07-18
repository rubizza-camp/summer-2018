require 'pry'
require 'russian_obscenity'
require 'terminal-table'
require 'optparse'

artists_hash = {}
# Class for battles participants
class Artist
  attr_reader :bad_words, :bad_words_number, :battler_name, :battles_number
  def initialize(battler_name_init)
    @battler_name = battler_name_init
    @battles_number = 0
  end

  def self.get_name_from_file(file)
    @battler_name = File.basename(file).split(/#|против|vs|VS|aka/).first.strip
  end

  def get_information(file_name)
    @battles_number += 1
    @text = File.read(file_name)
    @all_words = @text.scan(/[а-яА-ЯёЁ*]+/)
  end

  def words_count
    all_words_number = @all_words.size
  end

  def round_count
    words_count
    rounds = @text.scan(/Раунд \d/).size
   	rounds.zero? ? 1 : rounds
  end

  def bad_words_count
  	bad_words_number = 0
    bad_words_number += @all_words.count do |word|
      word.include?('*') || RussianObscenity.obscene?(word)
    end
  end

  def create_table_row
    [
      @battler_name,
      @battles_number.to_s + ' баттлов',
      bad_words_count.to_s + ' нецензурных слов',
      bad_words_in_battle.round(1).to_s + ' слов на баттл ',
      words_in_one_round.round(1).to_s + ' слов в раунде'
    ]
  end

  private

  def bad_words_in_battle
    (bad_words_count.to_f / @battles_number.to_f).to_f
  end

  def words_in_one_round
    (words_count.to_f / round_count.to_f).to_i
  end
end

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    Dir.glob('./battles2/*').reject do |path|
      name_of_artist = Artist.get_name_from_file(path)
      artists_hash[name_of_artist] ||= Artist.new(name_of_artist)
      artists_hash[name_of_artist].get_information(path)
    end
    rapers_for_input = artists_hash.sort_by \
    { |_, item| -item.bad_words_count }.first(top_bad_words.to_i)
    system('clear')
    puts Terminal::Table.new(rows: rapers_for_input.map \
      { |row| row[1].create_table_row })
  end
end.parse!

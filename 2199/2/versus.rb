require 'pry'
require 'yaml'
require 'russian_obscenity'
require 'terminal-table'
require 'optparse'
require 'russian'

ALIASES = YAML.load_file('alias.yml')
rappers = {}
# :reek:TooManyInstanceVariables
# Participant container
class Participant
  attr_reader :name, :bad_words, :battle_count
  def initialize(name)
    @name = name
    @battle_count = 0
    @bad_words = 0
    @words_count = 0
    @rounds_count = 0
  end

  # :reek:NilCheck
  def self.name_from_file(filename)
    name = filename.split(/ против | vs | VS /).first.split('/').last.strip
    ALIASES.find do |_, aliases|
      aliases.include?(name)
    end&.first || name
  end

  def filthy(filename)
    @battle_count += 1
    text = File.read(filename)
    words = text.scan(/[а-яА-ЯёЁ*]+/)
    words.delete('***')
    words_and_round_counts(words, text)
  end

  def words_and_round_counts(words, text)
    @words_count += words.length
    rounds_count = text.scan(/Раунд \d/).length
    @rounds_count += rounds_count.zero? ? 1 : rounds_count
    bad_words_find(words)
  end

  def bad_words_find(words)
    @bad_words += words.count do |word|
      word.include?('*') || RussianObscenity.obscene?(word)
    end
  end

  def table_row
    [
      @name,
      "#{battle_count} " + Russian.pluralize(battle_count.to_i, 'баттл', 'баттла', 'баттлов'),
      "#{bad_words} нецензурных " + Russian.pluralize(bad_words.to_i, 'слово', 'слова', 'слов'),
      "#{bad_words_per_battle.round(2)} слова на баттл ",
      "#{words_per_round.round(2)} слов в раунде"
    ]
  end

  private

  def bad_words_per_battle
    @bad_words.to_f / @battle_count
  end

  def words_per_round
    @words_per_round = @words_count / @rounds_count.to_f
  end
end

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    Dir.glob('rap-battles/*') do |filename|
      next unless File.file?(filename)
      original_name = Participant.name_from_file(filename)
      rappers[original_name] ||= Participant.new(original_name)
      rappers[original_name].filthy(filename)
    end
    top_rapers = rappers.sort_by { |_, rapper_data| - rapper_data.bad_words }.first(top_bad_words.to_i)
    puts Terminal::Table.new(rows: top_rapers.map { |raper_row| raper_row[1].table_row })
  end
end.parse!

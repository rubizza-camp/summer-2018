require 'yaml'
require 'bundler'
Bundler.require

# :reek:InstanceVariableAssumption
# class Battle to collect information
class Battle
  def initialize(filename)
    @filename = filename
  end

  def bad_words_count
    words.count do |word|
      word.include?('*') || RussianObscenity.obscene?(word)
    end
  end

  def words_count
    words.count
  end

  def rounds_count
    rounds_count = text.scan(/Раунд \d/).length
    rounds_count.zero? ? 1 : rounds_count
  end

  private

  def text
    @text ||= File.read(@filename)
  end

  def words
    return @words if @words
    @words = text.scan(/[а-яА-ЯёЁ*]+/)
    @words.delete('***')
    @words
  end
end

# Participant container
class Participant
  attr_reader :name

  def initialize(name)
    @name = name
    @battles = []
  end

  def add_battle(filename)
    @battles << Battle.new(filename)
  end

  def table_row
    [
      @name,
      "#{battles_count} " + Russian.pluralize(battles_count.to_i, 'баттл', 'баттла', 'баттлов'),
      "#{bad_words_count} нецензурных " + Russian.pluralize(bad_words_count.to_i, 'слово', 'слова', 'слов'),
      "#{bad_words_per_battle.round(2)} слова на баттл ",
      "#{words_per_round.round(2)} слов в раунде"
    ]
  end

  def bad_words_count
    @bad_words_count ||= @battles.sum(&:bad_words_count)
  end

  private

  def bad_words_per_battle
    bad_words_count.to_f / battles_count
  end

  def words_count
    @battles.sum(&:words_count)
  end

  def rounds_count
    @battles.sum(&:rounds_count)
  end

  def battles_count
    @battles.count
  end

  def words_per_round
    words_count / rounds_count.to_f
  end
end

# class Participant store
class ParticipantStore
  attr_reader :participants

  def initialize
    @participants = load_participants
  end

  def top_by_bad_words(limit)
    participants.values.sort_by { |participant| - participant.bad_words_count }.first(limit)
  end

  private

  # :reek:DuplicateMethodCall
  # :reek:FeatureEnvy
  def load_participants
    Dir.glob('rap-battles/*').each_with_object({}) do |filename, participants|
      next unless File.file?(filename)
      original_name = find_participant_for_file(filename)
      participants[original_name] ||= Participant.new(original_name)
      participants[original_name].add_battle(filename)
    end
  end

  # :reek:NilCheck
  def find_participant_for_file(filename)
    name = filename.split(/ против | vs /i).first.split('/').last.strip
    aliases.find do |_, aliases|
      aliases.include?(name)
    end&.first || name
  end

  def aliases
    @aliases ||= YAML.load_file('alias.yml')
  end
end

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    top_participants = ParticipantStore.new.top_by_bad_words(top_bad_words.to_i)
    puts Terminal::Table.new(rows: top_participants.map(&:table_row))
  end
  parser.on('--help') do
    puts 'Usage:'
    puts 'Parameter --top-bad-words=N show N the most abusive rapers.'
  end
end.parse!

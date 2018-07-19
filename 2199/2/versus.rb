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
    @words = text.scan(/[\wа-яА-ЯёЁ*]+/)
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

  def add_battle(battle)
    @bad_words_count = nil
    @battles << battle
  end

  def table_row
    [
      @name,
      "#{battles_count} #{Russian.pluralize(battles_count.to_i, 'баттл', 'баттла', 'баттлов')}",
      "#{bad_words_count} "\
      "#{Russian.pluralize(bad_words_count.to_i, 'нецензурное слово', 'нецензурных слова', 'нецензурных слов ')}",
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
  def initialize(battles_folder)
    @battles_folder = battles_folder
  end

  def top_by_bad_words(limit)
    participants.values.sort_by { |participant| - participant.bad_words_count }.first(limit)
  end

  private

  def participants
    @participants ||= Dir.glob("#{@battles_folder}/*").each_with_object({}) do |filename, participants_store|
      next unless File.file?(filename)
      original_name = ParticipantNameLoader.new(filename).participant_name
      participant = participants_store[original_name] ||= Participant.new(original_name)
      participant.add_battle(Battle.new(filename))
    end
  end
end

# class detects original participant name
class ParticipantNameLoader
  ALIASES = YAML.load_file('alias.yml')

  def initialize(filename)
    @filename = filename
  end

  # :reek:NilCheck
  def participant_name
    name = @filename.split(/ против | vs /i).first.split('/').last.strip
    ALIASES.find do |_, aliases|
      aliases.include?(name)
    end&.first || name
  end
end

OptionParser.new do |parser|
  parser.on('--top-bad-words=') do |top_bad_words|
    top_participants = ParticipantStore.new('rap-battles').top_by_bad_words(top_bad_words.to_i)
    puts Terminal::Table.new(rows: top_participants.map(&:table_row))
  end
  parser.on('--help') do
    puts 'Usage:'
    puts 'Parameter --top-bad-words=N show N the most abusive rapers.'
  end
end.parse!

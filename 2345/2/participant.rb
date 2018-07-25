require 'russian'
require 'json'

ALIASES = JSON.parse(File.read(File.dirname(__FILE__) + '/Alias.json'))

# Definition of a unique rapper name
class RapperUniqueName
  def initialize(filename)
    @filename = filename
  end

  def rapper_name
    battler = File.basename(@filename).strip
    name = battler[0...battler.index(/(против|aka|VS\b)/i)].strip
    ALIASES.find do |_, aliases|
      @find_key_aliases = aliases if aliases.include?(name) == true
    end
    ALIASES.key(@find_key_aliases)
  end
end

# Collecting info about rapper
class Rapper
  attr_reader :name

  def initialize(name, battles = [])
    @name = name
    @battles = battles
  end

  def add_battle(battle)
    Rapper.new(@name, @battles + [battle])
  end

  def bad_words_count
    @bad_words_count ||= @battles.sum(&:bad_words_count)
  end

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

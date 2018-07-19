require './word'
require './lyrics'

# this class provides all info about rapper
class Rapper
  attr_reader :stats, :name, :overall, :battles

  def initialize(name, all_battles_paths)
    @name = name
    @battles = all_battles_paths.select { |battle_path| battle_path.split(/( против | vs )/i).first.include?(@name) }
    @overall = { battles_num: @battles.size, rounds_num: Rapper.rapper_rounds(@battles) }
    @stats = Stats.new(self)
  end

  def self.count_rounds(battle_file_path)
    File.open(battle_file_path, 'r').select { |line| line[/Раунд \d/] }.count
  end

  def self.rapper_rounds(battles)
    num_of_rounds = 0
    battles.each do |battle_file_path|
      num_of_rounds += Rapper.count_rounds(battle_file_path)
    end
    num_of_rounds.zero? ? 1 : num_of_rounds
  end
end

# this class provides all stats about rapper
class Stats < Rapper
  attr_reader :words_info
  def initialize(rapper)
    @rapper = rapper
    @words_info = { all_words_num: 0, bad_words_num: 0, words_per_round: 0, bad_words_per_battle: 0 }
    rapper.battles.each do |battle_file_path|
      words_info[:all_words_num] += all_words_said_in(battle_file_path).size
      words_info[:bad_words_num] += bad_words_said_in(battle_file_path)
    end
    calculate_rest_stats
  end

  def calculate_rest_stats
    calculate_words_per_round
    calculate_bad_words_per_battle
  end

  def calculate_words_per_round
    words_info[:words_per_round] = (words_info[:all_words_num].to_f / @rapper.overall[:rounds_num]).round(2)
  end

  def calculate_bad_words_per_battle
    words_info[:bad_words_per_battle] = (words_info[:bad_words_num].to_f / @rapper.overall[:battles_num]).round(2)
  end

  def all_words_said_in(battle_file_path)
    Lyrics.new(battle_file_path, Battle.paired?(battle_file_path)).text_by(@rapper.name).split
  end

  def bad_words_said_in(battle_file_path)
    all_words_said_in(battle_file_path).select { |word| Word.obscene?(word) }.count
  end
end

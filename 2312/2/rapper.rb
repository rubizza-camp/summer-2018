require './word'
require './lyrics'

# this class provides all info about rapper
class Rapper
  # this class provides all stats about rapper
  class Stats
    attr_reader :rapper_stats
    def initialize(rapper)
      @rapper = rapper
      @rapper_stats = { all_words_num: 0, bad_words_num: 0, words_per_round: 0, bad_words_per_battle: 0 }
      collect_stats
      calculate_averages
    end

    def collect_stats
      @rapper.battles.each do |battle_file_path|
        lyrics = Lyrics.new(battle_file_path)
        rapper_stats[:all_words_num] += lyrics.all_words_said.size
        rapper_stats[:bad_words_num] += lyrics.bad_words_said
      end
    end

    def calculate_averages
      calculate_words_per_round
      calculate_bad_words_per_battle
    end

    def calculate_words_per_round
      rapper_stats[:words_per_round] = (rapper_stats[:all_words_num].to_f / @rapper.overall[:rounds_num]).round(2)
    end

    def calculate_bad_words_per_battle
      bad_words_num = rapper_stats[:bad_words_num]
      rapper_stats[:bad_words_per_battle] = (bad_words_num.to_f / @rapper.overall[:battles_num]).round(2)
    end
  end

  attr_reader :stats, :name, :overall, :battles

  def initialize(name, all_battles_paths)
    @name = name
    @battles = []
    @overall = {}
    collect_rapper_battles_from(all_battles_paths)
    collect_overall
    @stats = Stats.new(self)
  end

  def collect_rapper_battles_from(all_battles_paths)
    @battles = all_battles_paths.select { |battle_path| battle_path.split(/( против | vs )/i).first.include?(@name) }
  end

  def collect_overall
    overall[:battles_num] = @battles.size
    rounds = rapper_rounds
    overall[:rounds_num] = rounds.zero? ? 1 : rounds
  end

  def rapper_rounds
    @battles.map { |battle_file_path| Battle.new(battle_file_path).rounds_count }.count
  end
end

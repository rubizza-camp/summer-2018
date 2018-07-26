# this class provides all statistic about rapper
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

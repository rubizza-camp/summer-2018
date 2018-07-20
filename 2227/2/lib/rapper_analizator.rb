# Analysis of rappers statistic
class RapperAnalyzer
  DEFAULT_ROUNDS_COUNT = 3

  def self.calculate_statistic(name)
    new(name).fetch_statistic
  end

  def initialize(name)
    all_battles = DataStorage.find_all_battles(name)
    @number_of_battles = all_battles.size
    @battles_text = all_battles.values.join(' ')
  end

  def fetch_statistic
    {
      count: @number_of_battles,
      bad_words_count: bad_words_counter,
      avg_bad_words: avg_bad_words_in_battle,
      count_words_in_rounds: count_words_in_rounds
    }
  end

  private

  def bad_words_counter
    @bad_words_counter ||= count_bad_words
  end

  def avg_bad_words_in_battle
    (bad_words_counter / @number_of_battles.to_f).round(2)
  end

  def rounds_of_rappers
    rounds = @battles_text.scan(/Раунд\s[1-9]/).size
    rounds.zero? ? DEFAULT_ROUNDS_COUNT : rounds
  end

  def count_words_in_rounds
    words = battles_words.size
    (words.to_f / rounds_of_rappers).round(2)
  end

  def battles_words
    @battles_words ||= @battles_text.split(/[[:space:]]/)
  end

  def count_bad_words
    words_without_star = battles_words.reject { |word| word[/[*]/] }
    @battles_text.count('*') + RussianObscenity.find(words_without_star.join(' ')).size
  end
end

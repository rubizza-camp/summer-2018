# Analysis of rappers statistic
class RapperAnalyzer
  DEFAULT_ROUNDS_COUNT = 3

  def initialize(name, data)
    @data = data
    @all_battles = data.find_all_battles(name)
    @battles_text = @all_battles.values.join(' ')
  end

  def fetch_statistic
    {
      count: number_of_battles,
      bad_words_count: bad_words_counter,
      avg_bad_words: avg_bad_words_in_battle,
      count_words_in_rounds: count_words_in_rounds
    }
  end

  private

  def number_of_battles
    @all_battles.size
  end

  def bad_words_counter
    @bad_words_counter ||= count_bad_words
  end

  def avg_bad_words_in_battle
    (bad_words_counter / number_of_battles.to_f).round(2)
  end

  def rounds_of_rappers
    rounds = @battles_text.scan(/Раунд\s\d/).size
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
    @battles_text.count('*') + words_without_star.select { |word| RussianObscenity.obscene?(word) }.size
  end
end

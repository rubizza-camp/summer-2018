# Analysis of rappers statistic
class RapperAnalyzer
  DEFAULT_ROUNDS_COUNT = 3

  attr_reader :name

  def initialize(name, texts)
    @name = name
    @texts = texts
  end

  def number_of_battles
    @texts.size
  end

  def battles_text
    @texts.join(' ')
  end

  def bad_words_counter
    @bad_words_counter ||= count_bad_words
  end

  def rounds_of_rappers
    rounds = battles_text.scan(/Раунд\s\d/).size
    rounds.zero? ? DEFAULT_ROUNDS_COUNT : rounds
  end

  def battles_words
    @battles_words ||= battles_text.split(/[[:space:]]/)
  end

  def count_bad_words
    words_without_star = battles_words.reject { |word| word[/[*]/] }
    battles_text.count('*') + words_without_star.count { |word| RussianObscenity.obscene?(word) }
  end
end

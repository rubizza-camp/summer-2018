# Create rows with Russian words
class RapperRowPresenter
  def initialize(name, statistic)
    @statistic = statistic
    @name = name
  end

  def make_rows
    [
      @name,
      battles_count_for_raper_string,
      bad_words_count_string,
      avg_bad_words_string,
      count_words_in_round_string
    ]
  end

  private

  def battles_count_for_raper_string
    "#{battles_count_for_raper} #{Russian.p(battles_count_for_raper.to_i, 'баттл', 'батла', 'батлов')}"
  end

  def bad_words_count_string
    "#{bad_word_count} #{Russian.p(bad_word_count.to_i, 'нецензурное слово', 'нецензурных слова', 'нецензурных слов')}"
  end

  def avg_bad_words_string
    "#{avg_bad_words} #{Russian.p(avg_bad_words.to_i, 'слово', 'слова', 'cлов')} на баттл"
  end

  def count_words_in_round_string
    "#{count_words_in_round} #{Russian.p(count_words_in_round.to_i, 'слово', 'слова', 'слов')} в раунде"
  end

  def battles_count_for_raper
    @statistic[:count]
  end

  def bad_word_count
    @statistic[:bad_words_count]
  end

  def avg_bad_words
    @statistic[:avg_bad_words]
  end

  def count_words_in_round
    @statistic[:count_words_in_rounds]
  end
end

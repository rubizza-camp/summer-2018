# Create rows with Russian words
class RapperRowPresenter
  def initialize(row)
    @row = row
    @name ||= @row[0]
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
    @row[1]
  end

  def bad_word_count
    @row[2]
  end

  def avg_bad_words
    @row[3]
  end

  def count_words_in_round
    @row[4]
  end
end

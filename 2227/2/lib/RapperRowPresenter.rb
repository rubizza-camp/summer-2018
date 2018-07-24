# Create rows with Russian words
class RapperRowPresenter
  def initialize(rapper)
    @rapper = rapper
  end

  def make_rows
    [
      @rapper.name,
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
    @rapper.number_of_battles
  end

  def bad_word_count
    @rapper.bad_words_counter
  end

  def avg_bad_words
    (@rapper.bad_words_counter / @rapper.number_of_battles.to_f).round(2)
  end

  def count_words_in_round
    (@rapper.battles_words.size.to_f / @rapper.rounds_of_rappers).round(2)
  end
end

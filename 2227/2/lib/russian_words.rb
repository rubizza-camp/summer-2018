# Create endings for Russian words
class RussianWords
  def self.battles_count_for_raper(value)
    "#{value} #{Russian.p(value.to_i, 'баттл', 'батла', 'батлов')}"
  end

  def self.bad_words_count(value)
    "#{value} #{Russian.p(value.to_i, 'нецензурное слово', 'нецензурных слова', 'нецензурных слов')}"
  end

  def self.avg_bad_words(value)
    "#{value} #{Russian.p(value.to_i, 'слово', 'слова', 'cлов')} на баттл"
  end

  def self.count_words_in_round(value)
    "#{value} #{Russian.p(value.to_i, 'слово', 'слова', 'слов')} в раунде"
  end
end

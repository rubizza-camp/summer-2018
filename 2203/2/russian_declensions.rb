require 'russian'
require './top_words_statistic.rb'

# Prepares the output of statistics in the desired declension.
class RussianDeclensions
  def self.battles_count_for_raper(value)
    Russian.pluralize(value.to_i, 'баттл', 'батла', 'батлов')
  end

  def self.word(value)
    Russian.pluralize(value.to_i, 'слово', 'слова', 'слов')
  end

  def self.bad_words(value)
    Russian.pluralize(value.to_i, 'нецензурное слово', 'нецензурных слова', 'нецензурных слов')
  end
end

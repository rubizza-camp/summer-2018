require_relative 'row'
# The BadWordRow responsible for create row for print table
class BadWordRow < Row
  def initialize(author)
    @author = author
  end

  def to_a
    [@author.name,
     "#{@author.battles.size} батлов",
     "#{@author.bad_words.size} нецензурных слов",
     "#{format('%.2f', @author.bad_words_per_battles)} слова на баттл",
     "#{@author.words_per_battles_rounds} слова в раунде"]
  end
end

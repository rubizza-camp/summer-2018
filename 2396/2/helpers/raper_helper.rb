# This is module RaperHelper
module RaperHelper
  def self.formatting_word_say(word)
    "#{word} #{Russian.p(word, 'слово', 'слова', 'слов', 'слов')}"
  end

  def self.formatting_word_battle(word)
    "#{word} #{Russian.p(word, 'баттл', 'баттла', 'баттлов')}"
  end

  def self.formatting_word_obscence_word(word)
    "#{word} #{Russian.p(word, 'нецензурное слово', 'нецензурных слова',
                         'нецензурных слов')}"
  end
end

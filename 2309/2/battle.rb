# Class one battle
class Battle

  def initialize(title)
    @title = title
  end

  def bad_words
    File.read('bad_words').split(', ')
  end

  def read_battle
    text = File.read(@title)
    text = text.downcase
    text = text.scan(/[а-яёa-z*]+/)
  end

  def bad_words_count
    @bad_words_count ||= read_battle.count { |word| word.include?('*') || bad_words.include?(word) }
  end

  def sum_all_words
    @sum_all_words ||= read_battle.count
  end
end

a = Battle.new('rap-battles/ Oxxxymiron VS Гнойный aka Слава КПСС (VERSUS VS SLOVOSPB)')
puts a.sum_all_words.inspect
puts a.bad_words_count.inspect

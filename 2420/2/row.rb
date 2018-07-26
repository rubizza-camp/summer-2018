# :reek:TooManyInstanceVariables

# class Row
class Row
  attr_reader :name, :battles_count, :bad_words_count, :words_in_battle, :words_in_raund

  def initialize(name, battles_count, bad_words_count, words_in_battle, words_in_raund)
    @name = name
    @battles_count = battles_count
    @bad_words_count = bad_words_count
    @words_in_battle = words_in_battle
    @words_in_raund = words_in_raund
  end

  def run
    rows = [name.to_s,
            " #{battles_count} батл" + correct_ending,
            " #{bad_words_count} нецензурных слов ",
            " #{words_in_battle}  слова на батл ",
            " #{words_in_raund} слов в раунде"]
    rows
  end

  private

  def correct_ending
    if battles_count < 2
      ''
    elsif battles_count > 1 && battles_count <= 4
      'a'
    elsif battles_count >= 5
      'ов'
    end
  end
end

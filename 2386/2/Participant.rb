# Class contain participant data
class Participant
  attr_reader :name, :battles
  def initialize(name, battles = [])
    @name = name
    @battles = battles
  end

  def words_count
    @battles.sum(&:words_count)
  end

  def count_bad_words
    @battles.sum(&:count_bad_words)
  end

  def count_rounds
    @battles.sum(&:count_rounds)
  end

  def bad_per_round
    count_bad_words.to_f / @battles.size
  end

  def words_per_round
    words_count.to_f / count_rounds
  end

  def participant_row
    [
      @name,
      "#{@battles.size} батлов",
      "#{count_bad_words} нецензурных слов",
      "#{bad_per_round.round(2)} слов на батл",
      "#{words_per_round.round(2)} слов в раунде"
    ]
  end
end
